//
//  Place.swift
//  ProjectRide
//
//  Created by Yannick Winter on 08.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import JSONJoy
import CoreLocation

class Place: Object, JSONJoy, Entity {

    var entityName: String {
        return "Place"
    }

    static let idKeyName: String = "id"
    static let latitudeKeyName: String = "latitude"
    static let longitudeKeyName: String = "longitude"
    static let nameKeyName: String = "name"
    static let postcodeKeyName: String = "postcode"

    dynamic var id: String = ""
    private dynamic var latitude: Double = 0
    private dynamic var longitude: Double = 0
    dynamic var name: String = ""
    dynamic var postcode: String = ""

    init(id: String, latitude: Double, longitude: Double, name: String, postcode: String) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.postcode = postcode
        super.init()
    }

    required init(_ decoder: JSONDecoder) throws {
        self.id = try decoder[Place.idKeyName].getString()
        self.latitude = try decoder[Place.latitudeKeyName].getDouble()
        self.longitude = try decoder[Place.longitudeKeyName].getDouble()
        self.name = try decoder[Place.nameKeyName].getString()
        self.postcode = try decoder[Place.postcodeKeyName].getString()
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

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

}
