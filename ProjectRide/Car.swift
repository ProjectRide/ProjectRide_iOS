//
//  Car.swift
//  ProjectRide
//
//  Created by Yannick Winter on 07.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import JSONJoy

class Car: Object, JSONJoy, Entity {

    var entityName: String {
        return "Car"
    }

    static let idKeyName: String = "id"
    static let makeKeyName: String = "make"
    static let modelKeyName: String = "model"
    static let colorKeyName: String = "color"
    static let userIdKeyName: String = "userId"

    dynamic var id: String = ""
    dynamic var make: String = ""
    dynamic var model: String = ""
    dynamic var color: String = ""
    dynamic var userId: String = ""

    init(id: String, make: String, model: String, color: String, userId: String) {
        self.id = id
        self.make = make
        self.model = model
        self.color = color
        self.userId = userId
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
        self.id = try decoder[Car.idKeyName].getString()
        self.make = try decoder[Car.makeKeyName].getString()
        self.model = try decoder[Car.modelKeyName].getString()
        self.color = try decoder[Car.colorKeyName].getString()
        self.userId = try decoder[Car.userIdKeyName].getString()
        super.init()
    }

}
