//
//  ApiTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 09.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import JSONJoy
@testable import ProjectRide

class ApiTests: XCTestCase {

    static let apiConfig = ApiConfigImpl(baseURL: "http://somenotexistingurl.de/")
    static let entityName = "Entity"

    func testURLForEntity() {
        let dummyApi = ApiDummyImpl(apiConfig: ApiTests.apiConfig)
        var didCallCallback = false
        let responseExpectation = expectation(description: "Waiting for an error response")
        dummyApi.fetch(entityName: ApiTests.entityName) { jsonDecoder, error in
            if error != nil {
                didCallCallback = true
                responseExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10) {_ in
            XCTAssertTrue(didCallCallback)
        }
    }

}

class ApiDummyImpl: Api {

    var apiConfig: ApiConfig

    required init(apiConfig: ApiConfig) {
        self.apiConfig = apiConfig
    }

}
