//
//  WebSocketMessageSenderTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 18.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import ProjectRide

class WebSocketMessageSenderTests: XCTestCase {

    func testSendsMessageOnce() {
        let mockWS = WebsocketMockClass()
        let sender = WebSocketMessageSender(connection: mockWS)
        sender.send(message: "msg")
        guard mockWS.message == "msg" else {
            XCTFail()
            return
        }
        mockWS.message = nil
        sender.didSuccesfullyConnect()
        XCTAssertNil(mockWS.message)
    }

    func testSendsMessageAfterReconnect() {
        let mockWS = WebsocketMockClass(shouldDisplayAsConnected: false)
        let sender = WebSocketMessageSender(connection: mockWS)
        sender.send(message: "msg")
        guard mockWS.message == nil else {
            XCTFail()
            return
        }
        mockWS.shouldDisplayAsConnected = true
        sender.didSuccesfullyConnect()
        XCTAssertTrue(mockWS.message == "msg")
    }

}
