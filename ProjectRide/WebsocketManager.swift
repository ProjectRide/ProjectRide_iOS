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

class WebsocketManager: WebsocketConnection {

    private static var instance: WebsocketManager?

    static func sharedInstance(websocketConnection: WebSocketI? = nil, websocketSender: WebSocketMessageSenderI? = nil) -> WebsocketManager {
        guard let instance = self.instance else {
            if let connection = websocketConnection, let sender = websocketSender {
                self.instance = WebsocketManager(websocketI: connection, sender: sender)
            } else {
                let connection = WebSocket(url: WebsocketConfig().url)
                self.instance = WebsocketManager(websocketI: connection, sender: WebSocketMessageSender(connection: connection))
            }
            return self.sharedInstance()
        }
        return instance
    }

    private let connection: WebSocketI
    private let reconnector: WebSocketReconnector
    private let messageSender: WebSocketMessageSenderI

    private init(websocketI: WebSocketI, sender: WebSocketMessageSenderI) {
        self.connection = websocketI
        self.reconnector = WebSocketReconnector(delegate: self.connection)
        self.messageSender = sender
        self.connection.onConnect = self.onConnect
    }

    // MARK: WebsocketConnection

    func send(message: WebsocketMessageSerializable) {
        let decoder = JSONDecoder(message.messageDictionary)
        if messageContainsType(decodedMessage: decoder) {
            let message = decoder.print()
            self.messageSender.send(message: message)
        }
    }

    func onConnect(_: Void) -> Void {
        self.messageSender.didSuccesfullyConnect()
    }

    private func messageContainsType(decodedMessage: JSONDecoder) -> Bool {
        do {
            _ = try decodedMessage["type"].getString()
            return true
        } catch {
            return false
        }
    }

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

protocol WebSocketI: WebSocketReconnectorDelegate {

    func send(string: String)
    var delegate: WebSocketDelegate? { get set }
    var onConnect: ((Void) -> Void)? { get set }

}

extension WebSocket: WebSocketI {

    func send(string: String) {
        self.write(string: string)
    }

    func reconnect() {
        self.connect()
    }

}
