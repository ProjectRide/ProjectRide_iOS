//
//  LocationTrackerTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import ProjectRide

class LocationTrackerTests: XCTestCase {

    func testAddedNewLocation() {

        let location = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        let position = Position(coordinate: location)
        let mockWebsocketConnection = WebSocketConnectionMockClass()
        let locationTracker = LocationTracker.sharedInstance(connectionManager: mockWebsocketConnection)
        locationTracker.addPosition(position: position)
        XCTAssertNotNil(mockWebsocketConnection.message)
    }

}

class WebSocketConnectionMockClass: WebsocketConnection {

    var message: WebsocketMessageSerializable? = nil

    func send(message: WebsocketMessageSerializable) {
        self.message = message
    }

}
