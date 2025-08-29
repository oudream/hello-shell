import socket
import threading


def handle_client(client_socket, client_address):
    print(f"Connection established with {client_address}")
    while True:
        try:
            data = client_socket.recv(1024)
            if not data:
                break
            print(f"Received data of length: {len(data)} bytes from {client_address}")
        except Exception as e:
            print(f"Error receiving data from {client_address}: {e}")
            break
    client_socket.close()
    print(f"Connection with {client_address} closed")


def listen_for_exit():
    while True:
        user_input = input()
        if user_input.strip().lower() == 'q':
            print("Exiting server...")
            break
    exit(0)


def start_tcp_server(ip, port):
    try:
        # 创建套接字
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # 绑定指定的 IP 和端口
        server_socket.bind((ip, port))

        # 设置最大连接队列数
        server_socket.listen(5)
        print(f"Server is running on {ip}:{port} and waiting for connections...")

        # 启动监听退出线程
        threading.Thread(target=listen_for_exit, daemon=True).start()

        while True:
            # 等待客户端连接
            client_socket, client_address = server_socket.accept()
            client_thread = threading.Thread(target=handle_client, args=(client_socket, client_address))
            client_thread.start()

    except Exception as e:
        print(f"Error: {e}")

    finally:
        server_socket.close()


# 指定绑定的本地 IP 和端口
if __name__ == "__main__":
    LOCAL_IP = "172.18.103.220"  # 替换为需要绑定的 IP 地址
    PORT = 8080  # 替换为需要绑定的端口号

    start_tcp_server(LOCAL_IP, PORT)
