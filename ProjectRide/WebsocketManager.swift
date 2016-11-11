//
//  WebsocketManager.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Starscream
import JSONJoy

class WebsocketManager: WebsocketConnection, WebSocketDelegate {

    private static var instance: WebsocketManager?

    static func sharedInstance(websocketConnection: WebSocketI? = nil) -> WebsocketManager {
        guard let instance = self.instance else {
            if let connection = websocketConnection {
                self.instance = WebsocketManager(websocketI: connection)
            } else {
                self.instance = WebsocketManager(config: WebsocketConfig())
            }
            return self.sharedInstance()
        }
        return instance
    }

    let connection: WebSocketI

    private init(config: WebsocketConfiguration) {
        self.connection = WebSocket(url: config.url)
        self.connection.delegate = self
    }

    private init(websocketI: WebSocketI) {
        self.connection = websocketI
        self.connection.delegate = self
    }

    // MARK: WebsocketConnection

    func send(message: WebsocketMessageSerializable) {
        let decoder = JSONDecoder(message.messageDictionary)
        if messageContainsType(decodedMessage: decoder) {
            self.connection.send(string: decoder.print())
        }
    }

    private func messageContainsType(decodedMessage: JSONDecoder) -> Bool {
        do {
            _ = try decodedMessage["type"].getString()
            return true
        } catch {
            return false
        }
    }

    // MARK: WebSocketDelegate

    func websocketDidConnect(socket: WebSocket) {
        print("succesfully connected to WS: \(socket.currentURL)")
    }

    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("disconnected from WS: \(socket.currentURL), error: \(error?.localizedDescription)")
    }

    func websocketDidReceiveMessage(socket: WebSocket, text: String) {}

    func websocketDidReceiveData(socket: WebSocket, data: Data) {}

}

struct WebsocketMessageType {

    let name: String

}

protocol WebsocketConnection {

    func send(message: WebsocketMessageSerializable)

}

protocol WebsocketConfiguration {

    var url: URL { get }

}

protocol WebSocketI {

    func send(string: String)
    var delegate: WebSocketDelegate? { get set }

}

extension WebSocket: WebSocketI {

    func send(string: String) {
        self.write(string: string)
    }

}
