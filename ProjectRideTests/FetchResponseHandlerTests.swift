//
//  FetchResponseHandlerTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 09.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import JSONJoy
@testable import ProjectRide

class FetchResponseHandlerTests: XCTestCase {

    let succesfullHttpResponse = HTTPURLResponse(url: URL(string: "http://test.de/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let unsuccesfullHttpResponse = HTTPURLResponse(url: URL(string: "http://test.de/")!, statusCode: 210, httpVersion: nil, headerFields: nil)

    let jsonData = "{\"Key\":\"Value\"}".data(using: .utf8)
    let incorrectFormattedReponseData = "Incorrectly formatted".data(using: .utf8)

    func testSuccessfulFetch() {
        let handler = FetchResponseHandler(response: succesfullHttpResponse, data: jsonData, error: nil)
        do {
            let jsonDecoder = try handler.handle()
            let valueToKey = try jsonDecoder["Key"].getString()
            XCTAssertTrue(valueToKey == "Value")
        } catch {
            XCTFail()
        }
    }

    func testSuccessfulFetchWithoutData() {
        let handler = FetchResponseHandler(response: succesfullHttpResponse, data: nil, error: nil)
        XCTAssertThrowsError(try handler.handle())
    }

    func testFetchWithoutAnything() {
        let handler = FetchResponseHandler(response: nil, data: nil, error: nil)
        XCTAssertThrowsError(try handler.handle())
    }

    func testUnsuccessfulFetch() {
        let handler = FetchResponseHandler(response: unsuccesfullHttpResponse, data: jsonData, error: nil)
        XCTAssertThrowsError(try handler.handle())
    }

    func testErroredFetch() {
        let handler = FetchResponseHandler(response: nil, data: nil, error: FetchError())
        XCTAssertThrowsError(try handler.handle())
    }


}
