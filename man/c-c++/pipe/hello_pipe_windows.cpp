class NamedPipeServer {
public:
    NamedPipeServer(const std::wstring& pipeName, DWORD bufferSize = 4096)
        : pipeName_(L"\\\\.\\pipe\\" + pipeName), bufferSize_(bufferSize) {}

    void Run() {
        while (true) {
            HANDLE hPipe = CreateNamedPipe(
                pipeName_.c_str(),
                PIPE_ACCESS_DUPLEX,
                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT,
                PIPE_UNLIMITED_INSTANCES,
                bufferSize_,
                bufferSize_,
                0,
                NULL);

            if (hPipe == INVALID_HANDLE_VALUE) {
                std::cerr << "CreateNamedPipe failed, GLE=" << GetLastError() << std::endl;
                return;
            }

            std::cout << "Waiting for client connection..." << std::endl;

            BOOL connected = ConnectNamedPipe(hPipe, NULL) ?
                TRUE : (GetLastError() == ERROR_PIPE_CONNECTED);

            if (!connected) {
                std::cerr << "ConnectNamedPipe failed, GLE=" << GetLastError() << std::endl;
                CloseHandle(hPipe);
                continue;
            }

            std::cout << "Client connected, processing commands..." << std::endl;

            // 处理客户端请求
            if (!ProcessClientRequests(hPipe)) {
                std::cerr << "Failed to process client requests." << std::endl;
            }

            DisconnectNamedPipe(hPipe);
            CloseHandle(hPipe);
        }
    }

private:
    std::wstring pipeName_;
    DWORD bufferSize_;

    bool ProcessClientRequests(HANDLE hPipe) {
        const DWORD readBufferSize = 4096;
        char readBuffer[readBufferSize];
        DWORD bytesRead;

        while (true) {
            BOOL result = ReadFile(hPipe, readBuffer, readBufferSize, &bytesRead, NULL);
            if (!result || bytesRead == 0) break;

            std::string command(readBuffer, bytesRead);

            if (command == "send file") {
                // 客户端请求发送文件，服务器应接收文件
                /*ReceiveFile(hPipe, "received_file.txt");
                SendResponse(hPipe, "File processed and saved.");*/
                HandleClient(hPipe);
            }
            else if (command == "heartbeat") {
                // 客户端发送心跳命令，服务器回复心跳
                SendResponse(hPipe, "Heartbeat ACK");
            }
            else if (command == "request status") {
                // 客户端请求服务器状态，服务器回复状态
                SendResponse(hPipe, "Server running and ready.");
            }
            else if (command == "shutdown") {
                // 客户端发送关闭命令，服务器准备关闭
                SendResponse(hPipe, "ACK");
                std::cout << "Shutdown command received. Server is shutting down..." << std::endl;
                return false; // 结束服务器运行
            }
            else {
                std::cerr << "Unknown command received: " << command << std::endl;
                SendResponse(hPipe, "Unknown command");
            }
        }
        return true;
    }

    void HandleClient(HANDLE hPipe) {
        const DWORD bufferSize = 4 * 1024 * 1024; // 使用4MB的缓冲区
        std::vector<char> fileContent;
        char buffer[bufferSize];
        DWORD bytesRead = 0, bytesWritten = 0;

        // 1. 接收文件内容
        while (ReadFile(hPipe, buffer, bufferSize, &bytesRead, NULL) && bytesRead > 0) {
            fileContent.insert(fileContent.end(), buffer, buffer + bytesRead);
        }
        std::cout << "File content received. Size: " << fileContent.size() << " bytes." << std::endl;

        // 2. 处理文件内容（示例中直接回复接收到的内容）
        // 如果文件很大，这里可能需要分块回复
        size_t totalSize = fileContent.size();
        size_t totalSent = 0;
        while (totalSent < totalSize) {
            DWORD currentBlockSize = static_cast<DWORD>(std::min(static_cast<size_t>(bufferSize), totalSize - totalSent));
            if (!WriteFile(hPipe, fileContent.data() + totalSent, currentBlockSize, &bytesWritten, NULL) || bytesWritten == 0) {
                std::cerr << "Failed to send file content block to client, GLE=" << GetLastError() << std::endl;
                break;
            }
            totalSent += bytesWritten;
        }
        std::cout << "File content sent back to client." << std::endl;
    }

    void ReceiveFile(HANDLE hPipe, const std::string& filePath) {
        std::ofstream outputFile(filePath, std::ios::binary | std::ios::out);
        if (!outputFile) {
            std::cerr << "Failed to open file for writing: " << filePath << std::endl;
            return;
        }

        DWORD bytesRead;
        std::vector<char> buffer(bufferSize_);
        while (ReadFile(hPipe, buffer.data(), bufferSize_, &bytesRead, NULL) && bytesRead > 0) {
            outputFile.write(buffer.data(), bytesRead);
        }
        std::cout << "File received and saved: " << filePath << std::endl;
    }

    void SendResponse(HANDLE hPipe, const std::string& response) {
        DWORD bytesWritten;
        WriteFile(hPipe, response.c_str(), response.length(), &bytesWritten, NULL);
    }

    void SendFile(HANDLE hPipe, const std::string& filePath) {
        std::ifstream inputFile(filePath, std::ios::binary | std::ios::in);
        if (!inputFile) {
            std::cerr << "Failed to open file for reading: " << filePath << std::endl;
            return;
        }

        inputFile.seekg(0, std::ios::end);
        size_t fileSize = inputFile.tellg();
        inputFile.seekg(0, std::ios::beg);

        std::vector<char> buffer(bufferSize_);
        while (!inputFile.eof()) {
            inputFile.read(buffer.data(), buffer.size());
            size_t dataToWrite = inputFile.gcount();
            DWORD bytesWritten;
            WriteFile(hPipe, buffer.data(), dataToWrite, &bytesWritten, NULL);
        }
        std::cout << "File sent: " << filePath << std::endl;
    }
};