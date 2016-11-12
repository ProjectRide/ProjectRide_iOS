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
    let manager = WebsocketManager.sharedInstance(websocketConnection: WebsocketManagerTests.mockWS)

    override func tearDown() {
        WebsocketManagerTests.mockWS.message = nil
    }

    func testSendMessage() {
        let mockMessage = MockMessage(addsType: true)
        manager.send(message: mockMessage)
        XCTAssertTrue(WebsocketManagerTests.mockWS.message == mockMessage.messageString)
    }

    func testShouldNotSendMessage() {
        let mockMessage = MockMessage(addsType: false)
        manager.send(message: mockMessage)
        XCTAssertNil(WebsocketManagerTests.mockWS.message)
    }

}

class WebsocketMockClass: WebSocketI {

    var message: String?
    var delegate: WebSocketDelegate? = nil

    func send(string: String) {
        self.message = string
        print(self.message)
    }

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
