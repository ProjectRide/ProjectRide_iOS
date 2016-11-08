//
//  DateExtensions.swift
//  ProjectRide
//
//  Created by Yannick Winter on 07.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation

extension Date {

    static func fromAPIDateString(apiDateString: String) throws -> Date {
        guard let timeIntervalFromString = TimeInterval(apiDateString) else {
            throw UnreadableDateStringError(originalValue: apiDateString)
        }
        return Date(timeIntervalSince1970: timeIntervalFromString)
    }

}

class UnreadableDateStringError: Error {

    let originalValue: String

    init(originalValue: String) {
        self.originalValue = originalValue
    }

    var localizedDescription: String {
        return "Unable to serialize \(self.originalValue)."
    }

}
