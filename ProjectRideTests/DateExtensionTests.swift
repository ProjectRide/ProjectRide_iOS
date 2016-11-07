//
//  DateExtensionTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 07.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Foundation
import XCTest
@testable import ProjectRide

class DateExtensionTests: XCTestCase {

    func testWithCorrectDateString() {
        do {
            let timeInterval = TimeInterval(123456)
            let correctDate = Date(timeIntervalSince1970: timeInterval)
            let intervalString = "\(timeInterval)"
            let testDate = try Date.fromAPIDateString(apiDateString: intervalString)
            XCTAssertEqual(correctDate, testDate)

        } catch {
            XCTFail()
        }
    }

    func testWithCorruptedDateString() {
        let dateString = "ABC"
        XCTAssertThrowsError(try Date.fromAPIDateString(apiDateString: dateString))
    }

}
