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

    func handle() -> (jsonDecoder: JSONDecoder?, error: Error?) {
        if let error = self.error {
            return (nil, error)
        }
        if self.isUnsuccessfulStatusCode(statusCode: self.response?.statusCode) {
            return (nil, FetchError())
        }
        if let data = self.data {
            let responseString = String(data: data, encoding: .utf8)
            return (JSONDecoder(responseString), nil)
        }
        return (nil, FetchError())
    }

    private func isUnsuccessfulStatusCode(statusCode: Int?) -> Bool {
        return !self.isSuccessfulHTTPStatusCode(statusCode: statusCode)
    }

    private func isSuccessfulHTTPStatusCode(statusCode: Int?) -> Bool {
        return statusCode == 200 || statusCode == 201
    }

}

class FetchError: Error { }
