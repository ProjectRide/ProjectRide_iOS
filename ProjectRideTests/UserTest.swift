//
//  UserTest.swift
//  ProjectRide
//
//  Created by Yannick Winter on 04.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import JSONJoy
@testable import ProjectRide

class UserTest: XCTestCase {

    static let ID = "ABC"
    static let firstName = "Max"
    static let lastName = "Mustermann"
    static let email = "max@mustermann.de"
    static let phone = "0123456789"
    static let aboutMe = "It'se me Maxio"
    static let sex = "M"
    static let unknownSex = "C"

    func createBaseUser() throws -> User {
        let user = try User(id: UserTest.ID, firstName: UserTest.firstName, lastName: UserTest.lastName, email: UserTest.email, phoneNumber: UserTest.phone, aboutMe: UserTest.aboutMe, sexString: UserTest.sex, birthdate: nil, memberSince: nil, image: nil)
        return user
    }

    func createBasicJSONDecoder() -> JSONDecoder {
        let userJSON = "{ \"\(User.idKeyName)\": \"\(UserTest.ID)\", \"\(User.firstNameKeyName)\": \"\(UserTest.firstName)\", \"\(User.lastNameKeyName)\": \"\(UserTest.lastName)\", \"\(User.sexKeyName)\": \"\(UserTest.sex)\", \"\(User.emailKeyName)\": \"\(UserTest.email)\", \"\(User.phoneNumberKeyName)\": \"\(UserTest.phone)\", \"\(User.aboutMeKeyName)\": \"\(UserTest.aboutMe)\" }".data(using: .utf8)!
        return JSONDecoder(userJSON)
    }

    func testUserWithManualData() {
        do {
            let user = try self.createBaseUser()

            XCTAssertTrue(user.id == UserTest.ID && user.firstName == UserTest.firstName && user.lastName == UserTest.lastName && user.sexString == UserTest.sex && user.email == UserTest.email && user.phoneNumber == UserTest.phone && user.aboutMe == UserTest.aboutMe)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testUnknownSexWithManualData() {
        do {
            _ = try User(id: UserTest.ID, firstName: UserTest.firstName, lastName: UserTest.lastName, email: UserTest.email, phoneNumber: UserTest.phone, aboutMe: UserTest.aboutMe, sexString: UserTest.unknownSex, birthdate: nil, memberSince: nil, image: nil)
            XCTAssertTrue(false)
        } catch {
            XCTAssertTrue(error as? UnknownSexError != nil)
        }
    }

    func testUserWithJSONSuccess() {
        let decoder = self.createBasicJSONDecoder()

        do {
            let user = try User(decoder)

            XCTAssertTrue(user.id == UserTest.ID && user.firstName == UserTest.firstName && user.lastName == UserTest.lastName && user.sexString == UserTest.sex && user.email == UserTest.email && user.phoneNumber == UserTest.phone && user.aboutMe == UserTest.aboutMe)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testUnknownSexWithJSONData() {

        let userJSON = "{ \"\(User.idKeyName)\": \"\(UserTest.ID)\", \"\(User.firstNameKeyName)\": \"\(UserTest.firstName)\", \"\(User.lastNameKeyName)\": \"\(UserTest.lastName)\", \"\(User.sexKeyName)\": \"\(UserTest.unknownSex)\", \"\(User.emailKeyName)\": \"\(UserTest.email)\", \"\(User.phoneNumberKeyName)\": \"\(UserTest.phone)\", \"\(User.aboutMeKeyName)\": \"\(UserTest.aboutMe)\" }".data(using: .utf8)!
        do {
            _ = try User(JSONDecoder(userJSON))
            XCTAssertTrue(false)
        } catch {
            XCTAssertTrue(error as? UnknownSexError != nil)
        }
    }

    func testUserWithJSONFailure() {
        let userJSON = "{ \"WrongArgumentName\": \"\(UserTest.ID)\", \"\(User.firstNameKeyName)\": \"\(UserTest.firstName)\", \"\(User.lastNameKeyName)\": \"\(UserTest.lastName)\", \"\(User.sexKeyName)\": \"\(UserTest.sex)\", \"\(User.emailKeyName)\": \"\(UserTest.email)\", \"\(User.phoneNumberKeyName)\": \"\(UserTest.phone)\", \"\(User.aboutMeKeyName)\": \"\(UserTest.aboutMe)\" }".data(using: .utf8)!

        do {
            let _ = try User(JSONDecoder(userJSON))
            XCTAssertTrue(false)
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testGetMaleSex() {
        do {
            let user = try self.createBaseUser()
            let sex = user.sex
            XCTAssertTrue(sex == Sex.male)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testGetFemaleSex() {
        do {
            let user = try self.createBaseUser()
            user.sexString = Sex.female.rawValue
            let sex = user.sex
            XCTAssertTrue(sex == Sex.female)
        } catch {
            XCTAssertTrue(false)
        }

    }

    func testGetOtherSex() {
        do {
            let user = try self.createBaseUser()
            user.sexString = Sex.other.rawValue
            let sex = user.sex
            XCTAssertTrue(sex == Sex.other)
        } catch {
            XCTAssertTrue(false)
        }

    }

    func testGetEntityName() {
        do {
            let user = try self.createBaseUser()
            XCTAssertTrue(user.entityName == "User")
        } catch {
            XCTAssertTrue(false)
        }
    }

}
