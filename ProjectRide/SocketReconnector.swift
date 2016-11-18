//
//  SocketReconnector.swift
//  ProjectRide
//
//  Created by Yannick Winter on 18.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation

class WebSocketReconnector {

    static let timerInterval: TimeInterval = 5.0

    private let delegate: WebSocketReconnectorDelegate
    private var timer: Timer = Timer()

    init(delegate: WebSocketReconnectorDelegate) {
        self.delegate = delegate
        self.startTimer()
    }

    private func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: WebSocketReconnector.timerInterval, repeats: true, block: self.fireReconnect)
    }

    private func fireReconnect(timer: Timer) -> Void {
        if !self.delegate.isConnected {
            print("Attempting to Reconnect")
            self.delegate.reconnect()
        }
    }

}

protocol WebSocketReconnectorDelegate {

    var isConnected: Bool { get }
    func reconnect()

}
