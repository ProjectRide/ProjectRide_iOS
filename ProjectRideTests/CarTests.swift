//
//  CarTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 07.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import JSONJoy
@testable import ProjectRide

class CarTest: XCTestCase {

    let id = "1234"
    let make = "Mercedes"
    let model = "E-Klasse"
    let color = "Green"
    let userId = "ABC"


    func getCorrectCarWithManualData() -> Car {
        let car = Car(id: self.id, make: self.make, model: self.model, color: self.color, userId: self.userId)
        return car
    }

    func testConstructWithCorrectManualData() {
        let car = self.getCorrectCarWithManualData()

        XCTAssertTrue(car.make == make && car.model == model && car.color == color && car.userId == userId)
    }

    func testConstructWithCorrectJSONData() {
        let jsonData = "{\"\(Car.idKeyName)\": \"\(id)\", \"\(Car.makeKeyName)\": \"\(make)\", \"\(Car.modelKeyName)\":\"\(model)\", \"\(Car.colorKeyName)\":\"\(color)\", \"\(Car.userIdKeyName)\":\"\(userId)\"}".data(using: .utf8)

        do {
            let car = try Car(JSONDecoder(jsonData))
            XCTAssertTrue(car.make == make && car.model == model && car.color == color && car.userId == userId)
        } catch {
            XCTFail()
        }
    }

    func testConstructWithCorruptJSONData() {
        let jsonData = "{\"SomeWrongKey\": \"\(make)\", \"\(Car.modelKeyName)\":\"\(model)\", \"\(Car.colorKeyName)\":\"\(color)\", \"\(Car.userIdKeyName)\":\"\(userId)\"}".data(using: .utf8)
        XCTAssertThrowsError(try Car(JSONDecoder(jsonData)))
    }

    func testGetEntityName() {
        let car = self.getCorrectCarWithManualData()
        XCTAssertTrue(car.entityName == "Car")
    }

}
