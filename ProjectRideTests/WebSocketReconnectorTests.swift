//
//  WebSocketReconnectorTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 18.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import ProjectRide

class WebSocketReconnectorTests: XCTestCase {

    func testReconnectFires() {
        let webSocketMock = WebsocketMockClass(shouldDisplayAsConnected: false)
        _ = WebSocketReconnector(delegate: webSocketMock)

        let expectaton = expectation(description: "Expecting reconnector to call reconnect function of webSocket in specified Time")
        _ = Timer.scheduledTimer(withTimeInterval: WebSocketReconnector.timerInterval, repeats: false) { _ in
            expectaton.fulfill()
        }
        waitForExpectations(timeout: WebSocketReconnector.timerInterval + 3) {_ in
            XCTAssertTrue(webSocketMock.didAttemptToReconnect)
        }
    }

}
