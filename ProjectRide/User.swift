//
//  User.swift
//  ProjectRide
//
//  Created by Yannick Winter on 04.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import JSONJoy

class User: Object, JSONJoy {
    
    static let idKeyName = "id"
    static let firstNameKeyName = "firstName"
    static let lastNameKeyName = "lastName"
    static let emailKeyName = "email"
    static let phoneNumberKeyName = "phoneNumber"
    static let aboutMeKeyName = "aboutMe"
    static let sexKeyName = "sex"
    static let birthdateKeyName = "birthdate"
    static let memberSinceKeyName = "memberSince"
    static let imageKeyName = "image"
    
    dynamic var id = ""
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var email = ""
    dynamic var phoneNumber = ""
    dynamic var aboutMe = ""
    dynamic var sexString = ""
    dynamic var birthdate: Date? = nil
    dynamic var memberSince: Date? = nil
    dynamic var image: NSData? = nil
    
    var sex: Sex {
        get {
            guard let sex = Sex(rawValue: self.sexString) else {
                fatalError()
            }
            return sex
        }
    }
    
    init(id: String, firstName: String, lastName: String, email: String, phoneNumber: String, aboutMe: String, sexString: String, birthdate: Date?, memberSince: Date?, image: NSData?) throws {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.aboutMe = aboutMe
        self.sexString = sexString
        guard let _ = Sex(rawValue: self.sexString) else {
            throw UnknownSexError(description: "Unknown Sex")
        }
        self.birthdate = birthdate
        self.memberSince = memberSince
        self.image = image
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
        self.id = try decoder[User.idKeyName].getString()
        self.firstName = try decoder[User.firstNameKeyName].getString()
        self.lastName = try decoder[User.lastNameKeyName].getString()
        self.email = try decoder[User.emailKeyName].getString()
        self.phoneNumber = try decoder[User.phoneNumberKeyName].getString()
        self.aboutMe = try decoder[User.aboutMeKeyName].getString()
        self.sexString = try decoder[User.sexKeyName].getString()
        guard let _ = Sex(rawValue: sexString) else {
            throw UnknownSexError(description: "Unknown Sex")
        }
        
        // TODO: String to date
        self.birthdate = nil
        self.memberSince = nil
        // TODO: String to data
        self.image = nil
        super.init()
    }
    
}

enum Sex: String {
    case male = "M"
    case female = "F"
    case other = "O"
}

class UnknownSexError: Error {
    
    var localizedDescription: String = ""
    
    init(description: String) {
        self.localizedDescription = description
    }
    
}

