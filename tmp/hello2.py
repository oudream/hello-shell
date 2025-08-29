import socket
import threading


def send_data_to_server(server_ip, server_port):
    try:
        # 创建客户端套接字
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # 连接到服务端
        client_socket.connect((server_ip, server_port))
        print(f"Connected to server {server_ip}:{server_port}")

        while True:
            # 发送数据
            message = "Hello, Server!"  # 默认发送的消息
            client_socket.sendall(message.encode())

    except Exception as e:
        print(f"Error: {e}")

    finally:
        client_socket.close()
        print("Connection closed")


def listen_for_exit():
    while True:
        user_input = input()
        if user_input.strip().lower() == 'q':
            print("Exiting client...")
            exit(0)


if __name__ == "__main__":
    SERVER_IP = "172.18.103.220"  # 替换为服务端的 IP 地址
    SERVER_PORT = 8080  # 替换为服务端的端口号

    # 启动监听退出线程
    threading.Thread(target=listen_for_exit, daemon=True).start()

    # 启动数据发送功能
    send_data_to_server(SERVER_IP, SERVER_PORT)
