//
//  PositionTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import ProjectRide

class PositionTests: XCTestCase {

    func testMessageDictionary() {
        let coordinate = CLLocationCoordinate2D(latitude: 10, longitude: 20)
        let date = Date()
        let position = Position(coordinate: coordinate, date: date)
        let dict = position.messageDictionary
        XCTAssertTrue(
            dict[Position.typeKeyName] as? String == "Position" &&
            dict[Position.latitudeKeyName] as? CLLocationDegrees == coordinate.latitude &&
            dict[Position.longitudeKeyName] as? CLLocationDegrees == coordinate.longitude &&
            dict[Position.dateKeyName] as? TimeInterval == date.timeIntervalSince1970
        )
    }

}
