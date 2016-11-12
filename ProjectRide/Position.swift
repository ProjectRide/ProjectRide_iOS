//
//  Position.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import CoreLocation
import JSONJoy

struct Position: WebsocketMessageSerializable {

    static let typeKeyName: String = "type"
    static let latitudeKeyName: String = "latitude"
    static let longitudeKeyName: String = "longitude"
    static let dateKeyName: String = "date"

    var type: String {
        return "Position"
    }

    private let coordinate: CLLocationCoordinate2D
    private let date: Date

    init(coordinate: CLLocationCoordinate2D, date: Date = Date()) {
        self.coordinate = coordinate
        self.date = date
    }

    var messageDictionary: Dictionary <String, Any> {
        let dict: Dictionary<String, Any> = [
            Position.typeKeyName: "\(self.type)",
            Position.latitudeKeyName: self.coordinate.latitude,
            Position.longitudeKeyName: self.coordinate.longitude,
            Position.dateKeyName: self.date.timeIntervalSince1970
        ]
        return dict
    }

}

extension Position {

    static func fromLocation(location: CLLocation) -> Position {
        return Position(coordinate: location.coordinate, date: location.timestamp)
    }

}
