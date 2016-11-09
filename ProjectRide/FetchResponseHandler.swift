//
//  FetchResponseHandler.swift
//  ProjectRide
//
//  Created by Yannick Winter on 09.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import JSONJoy

class FetchResponseHandler {


    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }

    func handle() throws -> JSONDecoder {
        if let error = self.error {
            throw error
        }
        if self.isUnsuccessfulStatusCode(statusCode: self.response?.statusCode) {
            throw FetchError()
        }
        if let data = self.data {
            let responseString = String(data: data, encoding: .utf8)
            return JSONDecoder(responseString)
        }
        throw FetchError()
    }

    private func isUnsuccessfulStatusCode(statusCode: Int?) -> Bool {
        return !self.isSuccessfulHTTPStatusCode(statusCode: statusCode)
    }

    private func isSuccessfulHTTPStatusCode(statusCode: Int?) -> Bool {
        return statusCode == 200 || statusCode == 201
    }

}

class FetchError: Error {}
