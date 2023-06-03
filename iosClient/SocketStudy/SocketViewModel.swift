//
//  SocketViewModel.swift
//  SocketStudy
//
//  Created by 235 on 2023/06/03.
//

import Foundation
import SocketIO
class SocketViewModel : NSObject{
    static let shared = SocketViewModel()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
    var socket : SocketIOClient!
    override init(){
        super.init()
        socket = self.manager.socket(forNamespace: "/")
        establishConnection()
        setupSocketEvents()
    }
    func establishConnection() {
        socket.connect()
        print("소켓을 연결해보아요")
    }
    func closeConnection(){
        socket.disconnect()
        print("소켓 연결 종료!")
    }
    func sendMessage(_ message : String){
        socket.emit("message", message)
    }
    private func setupSocketEvents() {
         socket.on(clientEvent: .connect) { data, ack in
             print("Socket connected")
         }
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket disconnected")
        }
     }
}
