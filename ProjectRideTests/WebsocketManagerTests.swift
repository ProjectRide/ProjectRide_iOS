//
//  WebsocketManagerTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import Starscream
import JSONJoy
@testable import ProjectRide

class WebsocketManagerTests: XCTestCase {

    static let mockWS = WebsocketMockClass()
    static let mockSender = MockSender()
    let manager = WebsocketManager.sharedInstance(websocketConnection: mockWS, websocketSender: mockSender)

    override func tearDown() {
        WebsocketManagerTests.mockSender.message = nil
    }

    func testSendMessage() {
        let mockMessage = MockMessage(addsType: true)
        manager.send(message: mockMessage)
        XCTAssertTrue(WebsocketManagerTests.mockSender.message == mockMessage.messageString)
    }

    func testShouldNotSendMessage() {
        let mockMessage = MockMessage(addsType: false)
        manager.send(message: mockMessage)
        XCTAssertNil(WebsocketManagerTests.mockSender.message)
    }

    func testReactsToOnConnect() {
        WebsocketManagerTests.mockWS.onConnect?()
        XCTAssertTrue(WebsocketManagerTests.mockSender.didCallSuccesfullyConnect)
    }

}

class WebsocketMockClass: WebSocketI {

    var message: String?
    var delegate: WebSocketDelegate? = nil
    var shouldDisplayAsConnected: Bool = true
    var didAttemptToReconnect: Bool = false

    init(shouldDisplayAsConnected: Bool = true) {
        self.shouldDisplayAsConnected = shouldDisplayAsConnected
    }

    func send(string: String) {
        self.message = string
        print(self.message)
    }

    func reconnect() {
        self.didAttemptToReconnect = true
    }

    var isConnected: Bool {
        return self.shouldDisplayAsConnected
    }

    var onConnect: ((Void) -> Void)?

}

class MockMessage: WebsocketMessageSerializable {

    var type: String {
        return "MockType"
    }

    let addsType: Bool

    init(addsType: Bool) {
        self.addsType = addsType
    }

    var messageDictionary: Dictionary<String, Any> {
        if addsType {
            return [
                "type": self.type,
                "mockKey": "mockValue"
            ]
        }
        return ["mockKey": "mockValue"]

    }

    var messageString: String {
        let decoder = JSONDecoder(self.messageDictionary)
        return decoder.print()
    }

}

class MockSender: WebSocketMessageSenderI {

    var message: String?
    var didCallSuccesfullyConnect: Bool = false

    func send(message: String) {
        self.message = message
    }

    func didSuccesfullyConnect() {
        self.didCallSuccesfullyConnect = true
    }

}
