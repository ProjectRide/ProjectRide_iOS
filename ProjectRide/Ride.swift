//
//  Ride.swift
//  ProjectRide
//
//  Created by Yannick Winter on 07.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import JSONJoy

class Ride: Object, JSONJoy, Entity {

    var entityName: String {
        return "Ride"
    }

    static let idKeyName: String = "id"
    static let driverIdKeyName: String = "driverId"
    static let startDateKeyName: String = "startDate"
    static let endDateKeyName: String = "endDate"
    static let startPlaceIdKeyName: String = "startPlaceId"
    static let endPlaceIdKeyName: String = "endPlaceId"
    static let flexibleStartPlaceKeyName: String = "flexibleStartPlace"
    static let flexibleEndPlaceKeyName: String = "flexibleEndPlace"
    static let priceKeyName: String = "price"
    static let numberOfSeatsKeyName: String = "numberOfSeats"
    static let descriptionKeyName: String = "description"
    static let seriesKeyName: String = "series"

    dynamic var id: String = ""
    dynamic var driverId: String = ""
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date = Date()
    dynamic var startPlaceId: String = ""
    dynamic var endPlaceId: String = ""
    dynamic var flexibleStartPlace: Bool = false
    dynamic var flexibleEndPlace: Bool = false
    dynamic var price: Double = -1
    dynamic var numberOfSeats: Int = -1
    dynamic var descriptionText: String = ""
    dynamic var series: Bool = false

    // swiftlint:disable function_parameter_count
    init( id: String, driverId: String, startDate: Date, endDate: Date, startPlaceId: String, endPlaceId: String, flexibleStartPlace: Bool, flexibleEndPlace: Bool, price: Double, numberOfSeats: Int, descriptionText: String, series: Bool) {
        self.id = id
        self.driverId = driverId
        self.startDate = startDate
        self.endDate = endDate
        self.startPlaceId = startPlaceId
        self.endPlaceId = endPlaceId
        self.flexibleStartPlace = flexibleStartPlace
        self.flexibleEndPlace = flexibleEndPlace
        self.price = price
        self.numberOfSeats = numberOfSeats
        self.descriptionText = descriptionText
        self.series = series
        super.init()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(_ decoder: JSONDecoder) throws {
        self.id = try decoder[Ride.idKeyName].getString()
        self.driverId = try decoder[Ride.driverIdKeyName].getString()
        self.startDate = try Date.fromAPIDateString(apiDateString: decoder[Ride.startDateKeyName].getString())
        self.endDate = try Date.fromAPIDateString(apiDateString: decoder[Ride.endDateKeyName].getString())
        self.startPlaceId = try decoder[Ride.startPlaceIdKeyName].getString()
        self.endPlaceId = try decoder[Ride.endPlaceIdKeyName].getString()
        self.flexibleStartPlace = try decoder[Ride.flexibleStartPlaceKeyName].getBool()
        self.flexibleEndPlace = try decoder[Ride.flexibleEndPlaceKeyName].getBool()
        self.price = try decoder[Ride.priceKeyName].getDouble()
        self.numberOfSeats = try decoder[Ride.numberOfSeatsKeyName].getInt()
        self.descriptionText = try decoder[Ride.descriptionKeyName].getString()
        self.series = try decoder[Ride.seriesKeyName].getBool()
        super.init()
    }


}
