//
//  PlaceTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 08.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import JSONJoy
import CoreLocation
@testable import ProjectRide

class PlaceTests: XCTestCase {

    let id = "1234"
    let latitude: Double = 50.0000
    let longitude: Double = 13.0000
    let nameValue: String = "Kostheim"
    let postcode: String = "55246"

    func testSetupWithManualData() {
        let place = Place(id: id,
                          latitude: latitude,
                          longitude: longitude,
                          name: nameValue,
                          postcode: postcode
        )
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        XCTAssertTrue(place.id == id &&
            place.coordinate.latitude == coordinate.latitude &&
            place.coordinate.longitude == coordinate.longitude &&
            place.name == nameValue &&
            place.postcode == postcode
        )
    }

    func testSetupWithJSONData() {
        let jsonString = "{\"\(Place.idKeyName)\":\"\(self.id)\"," +
            "\"\(Place.latitudeKeyName)\":\(latitude), " +
            "\"\(Place.longitudeKeyName)\": \(longitude), " +
            "\"\(Place.nameKeyName)\": \"\(nameValue)\", " +
            " \"\(Place.postcodeKeyName)\": \"\(postcode)\" " +
            "}"
        let jsonData = jsonString.data(using: .utf8)

        do {
            let place = try Place(JSONDecoder(jsonData))
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            XCTAssertTrue(place.id == id &&
                place.coordinate.latitude == coordinate.latitude &&
                place.coordinate.longitude == coordinate.longitude &&
                place.name == nameValue &&
                place.postcode == postcode
            )
        } catch {
            XCTFail()
        }

    }

    func testSetupWithCorruptedJSON() {
        let jsonData = "{SomeWrongJsonString: ...}".data(using: .utf8)
        XCTAssertThrowsError(try Place(JSONDecoder(jsonData)))
    }

    func testGetEntityName() {
        XCTAssertEqual(Place().entityName, "Place")
    }


}
