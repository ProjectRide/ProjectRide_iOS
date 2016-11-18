//
//  WebSocketMessageSender.swift
//  ProjectRide
//
//  Created by Yannick Winter on 18.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Starscream

class WebSocketMessageSender: WebSocketMessageSenderI {

    let connection: WebSocketI
    var queue: [String] = []

    init(connection: WebSocketI) {
        self.connection = connection
    }

    func send(message: String) {
        self.queue.append(message)
        self.emptyQueue()
    }

    func didSuccesfullyConnect() {
        self.emptyQueue()
    }

    private func emptyQueue() {
        var keepMessages: [String] = []
        for i in 0 ..< self.queue.count {
            do {
                try self.sendWithWebSocket(message: self.queue[i])
            } catch {
                keepMessages.append(self.queue[i])
            }
        }
        self.queue = keepMessages
    }

    private func sendWithWebSocket(message: String) throws {
        guard self.connection.isConnected else {
            throw NotConnectedError()
        }
        self.connection.send(string: message)
    }

}

class NotConnectedError: Error {}

protocol WebSocketMessageSenderI {

    func send(message: String)
    func didSuccesfullyConnect()

}
