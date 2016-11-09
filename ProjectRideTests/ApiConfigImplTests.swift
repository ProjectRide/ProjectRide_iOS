//
//  ApiConfigImplTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 09.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
@testable import ProjectRide

class ApiConfigImplTests: XCTestCase {

    static let correctURL = "http://test.de/"
    static let inCorrectURL = "http://test.de"

    func testConstructWithCorrectURL() {
        let apiConfig = ApiConfigImpl(baseURL: ApiConfigImplTests.correctURL)
        XCTAssert(apiConfig.baseURL == ApiConfigImplTests.correctURL)
    }

    func testConstructWithIncorrectURL() {
        let apiConfig = ApiConfigImpl(baseURL: ApiConfigImplTests.inCorrectURL)
        XCTAssert(apiConfig.baseURL == ApiConfigImplTests.correctURL)
    }


}
