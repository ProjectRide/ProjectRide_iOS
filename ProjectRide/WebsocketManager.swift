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
    }

    private init(websocketI: WebSocketI) {
        self.connection = websocketI
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
