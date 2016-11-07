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

    let make = "Mercedes"
    let model = "E-Klasse"
    let color = "Green"
    let userId = "ABC"


    func getCorrectCarWithManualData() -> Car {
        let car = Car(make: self.make, model: self.model, color: self.color, userId: self.userId)
        return car
    }

    func testConstructWithCorrectManualData() {
        let car = self.getCorrectCarWithManualData()

        XCTAssertTrue(car.make == make && car.model == model && car.color == color && car.userId == userId)
    }

    func testConstructWithCorrectJSONData() {
        let jsonData = "{\"\(Car.makeKeyName)\": \"\(make)\", \"\(Car.modelKeyName)\":\"\(model)\", \"\(Car.colorKeyName)\":\"\(color)\", \"\(Car.userIdKeyName)\":\"\(userId)\"}".data(using: .utf8)

        do {
            let car = try Car(JSONDecoder(jsonData))
            XCTAssertTrue(car.make == make && car.model == model && car.color == color && car.userId == userId)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testConstructWithCorruptJSONData() {
        let jsonData = "{\"SomeWrongKey\": \"\(make)\", \"\(Car.modelKeyName)\":\"\(model)\", \"\(Car.colorKeyName)\":\"\(color)\", \"\(Car.userIdKeyName)\":\"\(userId)\"}".data(using: .utf8)
        do {
            _ = try Car(JSONDecoder(jsonData))
            XCTAssertTrue(false)
        } catch {
            XCTAssertTrue(true)
        }

    }

    func testGetEntityName() {
        let car = self.getCorrectCarWithManualData()
        XCTAssertTrue(car.entityName == "Car")
    }

}
