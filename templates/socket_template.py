#!/usr/bin/env python3
import socket
import threading
import sys 

class Server(): 
    def __init__(self): 
        self.bind_ip = "0.0.0.0"
        self.bind_port = 8080
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.bind((self.bind_ip, self.bind_port))
        self.server.listen()
        print ( "Listening on {}:{}".format(self.bind_ip, self.bind_port) )

    def handler(self, client_socket): 
            while True :
                req = client_socket.recv(4096)
                if req: 
                    decode = req.decode().split("\n")[0].split("\r")[0]
                    if decode == "exit" : 
                        client_socket.close()
                        sys.exit()
                    else : 
                        print("Message received : {}".format(decode))
                        client_socket.send(str.encode("__ACK__\n"))

    def run(self): 
        while True : 
            self.client_socket, self.client_address = self.server.accept()
            print ("Accepted connection from {}:{}".format(self.client_address[0], self.client_address[1]))

            self.client_handler = threading.Thread(
                    target=self.handler,
                    args=(self.client_socket,)
                    )

            self.client_handler.start()


if __name__=="__main__":
    server = Server()
    server.run()
