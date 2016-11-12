//
//  LocationGathererTests.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import ProjectRide

class LocationGathererTests: XCTestCase {

    func testAskForPermissions() {
        let delegate = MockLocationGathererDelegate()
        let locationManager = MockLocationManager(shouldAcceptBackgroundUsage: true)
        let gatherer = LocationGatherer(delegate: delegate, locationManager: locationManager)
        try? gatherer.startUpdatingLocation()
        XCTAssertTrue(locationManager.didAskForBackgroundUsage)
    }

    func testWithPermissions() {
        let delegate = MockLocationGathererDelegate()
        let locationManager = MockLocationManager(shouldAcceptBackgroundUsage: true)
        let gatherer = LocationGatherer(delegate: delegate, locationManager: locationManager)
        do {
            try gatherer.startUpdatingLocation()
            XCTAssertTrue(locationManager.hasBeenAskedToUpdateLocation)
        } catch {
            XCTFail()
        }
    }

    func testWithoutPermissions() {
        let delegate = MockLocationGathererDelegate()
        let locationManager = MockLocationManager(shouldAcceptBackgroundUsage: false)
        let gatherer = LocationGatherer(delegate: delegate, locationManager: locationManager)
        XCTAssertThrowsError(try gatherer.startUpdatingLocation())
    }

    func testWithLaterGrantedPermissions() {
        let delegate = MockLocationGathererDelegate()
        let locationManager = MockLocationManager(shouldAcceptBackgroundUsage: false)
        let gatherer = LocationGatherer(delegate: delegate, locationManager: locationManager)
        do {
            try gatherer.startUpdatingLocation()
        } catch {
            locationManager.sendPermissionsChanged()
            XCTAssertTrue(locationManager.hasBeenAskedToUpdateLocation)
        }
    }

    func testWithLaterGrantedPermissionsWithoutLocationUpdates() {
        let delegate = MockLocationGathererDelegate()
        let locationManager = MockLocationManager(shouldAcceptBackgroundUsage: false)
        _ = LocationGatherer(delegate: delegate, locationManager: locationManager)
        locationManager.sendPermissionsChanged()
        XCTAssertTrue(!locationManager.hasBeenAskedToUpdateLocation)

    }

    func testSendOutLocations() {
        let mockLocation = CLLocation(latitude: 10, longitude: 10)
        let delegate = MockLocationGathererDelegate()
        let locationManager = MockLocationManager(shouldAcceptBackgroundUsage: true)
        let gatherer = LocationGatherer(delegate: delegate, locationManager: locationManager)
        do {
            try gatherer.startUpdatingLocation()

            locationManager.sendOutMockLocation(location: mockLocation)
            XCTAssertNotNil(delegate.position)
        } catch {
            XCTFail()
        }
    }

}

class MockLocationManager: CLLocationManager {

    var didAskForBackgroundUsage: Bool = false
    var hasBeenAskedToUpdateLocation: Bool = false

    var acceptBackgroundUsage: Bool

    init(shouldAcceptBackgroundUsage: Bool) {
        self.acceptBackgroundUsage = shouldAcceptBackgroundUsage
    }

    override func requestAlwaysAuthorization() {
        self.didAskForBackgroundUsage = true
    }

    override func startUpdatingLocation() {
        self.hasBeenAskedToUpdateLocation = true
    }

    override var allowsBackgroundLocationUpdates: Bool {
        get {
            return self.acceptBackgroundUsage
        }
        set {
            // do nothing
        }
    }

    func sendOutMockLocation(location: CLLocation) {
        self.delegate?.locationManager?(self, didUpdateLocations: [location])
    }

    func sendPermissionsChanged() {
        self.acceptBackgroundUsage = !self.acceptBackgroundUsage
        self.delegate?.locationManager?(self, didChangeAuthorization: CLAuthorizationStatus.authorizedAlways)
    }

}

class MockLocationGathererDelegate: LocationGathererDelegate {

    var position: Position? = nil

    func addPosition(position: Position) {
        self.position = position
    }

}
