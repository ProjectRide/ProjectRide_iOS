//
//  RideTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 07.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import JSONJoy
@testable import ProjectRide

class RideTests: XCTestCase {

    let id = "1234"
    let driverId: String = "ABC"
    let startDate: Date = Date(timeIntervalSince1970: 123)
    let endDate: Date = Date(timeIntervalSince1970: 12345)
    let startPlaceId: String = "DEF"
    let endPlaceId: String = "GHI"
    let flexibleStartPlace: Bool = false
    let flexibleEndPlace: Bool = false
    let price: Double = 10
    let numberOfSeats: Int = 4
    let descriptionText: String = "MyDescription with Spaces"
    let series: Bool = false

    func getCorrectRideWithManualData() -> Ride {
        let ride = Ride(id: self.id, driverId: self.driverId, startDate: self.startDate, endDate: self.endDate, startPlaceId: self.startPlaceId, endPlaceId: self.endPlaceId, flexibleStartPlace: self.flexibleStartPlace, flexibleEndPlace: self.flexibleEndPlace, price: self.price, numberOfSeats: self.numberOfSeats, descriptionText: self.descriptionText, series: self.series)
        return ride
    }

    func testConstructWithCorrectManualData() {
        let ride = self.getCorrectRideWithManualData()
        XCTAssertTrue(ride.id == id && ride.driverId == driverId && ride.startDate == startDate && ride.endDate == endDate && ride.startPlaceId == startPlaceId && ride.endPlaceId == endPlaceId && ride.flexibleStartPlace == flexibleStartPlace && ride.flexibleEndPlace == flexibleEndPlace && ride.price == price && ride.numberOfSeats == numberOfSeats && ride.descriptionText == descriptionText && ride.series == series)
    }

    func testConstructWithCorrectJSONData() {
        let jsonString: String = "{\"\(Ride.idKeyName)\": \"\(id)\",\"\(Ride.driverIdKeyName)\": \"\(driverId)\",\"\(Ride.startDateKeyName)\":\"\(startDate.timeIntervalSince1970)\", \"\(Ride.endDateKeyName)\": \"\(endDate.timeIntervalSince1970)\", \"\(Ride.startPlaceIdKeyName)\": \"\(startPlaceId)\", \"\(Ride.endPlaceIdKeyName)\": \"\(endPlaceId)\", \"\(Ride.flexibleStartPlaceKeyName)\": \"\(flexibleStartPlace)\",\"\(Ride.flexibleEndPlaceKeyName)\": \"\(flexibleEndPlace)\", \"\(Ride.priceKeyName)\": \(price), \"\(Ride.numberOfSeatsKeyName)\": \(numberOfSeats), \"\(Ride.descriptionKeyName)\": \"\(descriptionText)\", \"\(Ride.seriesKeyName)\": \(series)}"

        do {
            print(jsonString)
            let ride = try Ride(JSONDecoder(jsonString.data(using: .utf8)))
            XCTAssertTrue(ride.id == id && ride.driverId == driverId && ride.startDate == startDate && ride.endDate == endDate && ride.startPlaceId == startPlaceId && ride.endPlaceId == endPlaceId && ride.flexibleStartPlace == flexibleStartPlace && ride.flexibleEndPlace == flexibleEndPlace && ride.price == price && ride.numberOfSeats == numberOfSeats && ride.descriptionText == descriptionText && ride.series == series)
        } catch {
            XCTFail()
        }
    }

    func testConstructWithCorruptJSONData() {
        let jsonData = "{\"SomeWrongKey\": \"someValue\"".data(using: .utf8)
        XCTAssertThrowsError(try Ride(JSONDecoder(jsonData)))
    }

    func testGetEntityName() {
        let ride = self.getCorrectRideWithManualData()
        XCTAssertTrue(ride.entityName == "Ride")
    }

}
