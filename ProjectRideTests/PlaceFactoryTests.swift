//
//  PlaceFactoryTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 08.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import ProjectRide

class PlaceFactoryTests: XCTestCase {

    func testCreateWithLocation() {
        let placeExpectation = self.expectation(description: "waitingForData")
        var called = false
        PlaceFactory.createPlaceWithCoordinate(coordinate: CLLocationCoordinate2D(latitude: 50.0, longitude: 8.2)) { place in
            called = true
            placeExpectation.fulfill()
        }

        self.waitForExpectations(timeout: 1000) { error in
            print(error)
            XCTAssertTrue(called)
        }




    }


}
