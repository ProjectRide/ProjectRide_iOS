//
//  LocationGatherer.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import CoreLocation

class LocationGatherer: NSObject, CLLocationManagerDelegate {

    private let delegate: LocationGathererDelegate
    private let locationManager: CLLocationManager
    private var shouldUpdateLocation: Bool = false

    init(delegate: LocationGathererDelegate, locationManager: CLLocationManager = CLLocationManager()) {
        self.delegate = delegate
        self.locationManager = locationManager
        super.init()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        self.locationManager.activityType = .automotiveNavigation
        self.locationManager.requestAlwaysAuthorization()
    }

    func startUpdatingLocation() throws {
        self.shouldUpdateLocation = true
        self.setupLocationManager()
        if self.locationManager.allowsBackgroundLocationUpdates {
            self.start()
            return
        }
        throw NotAuthorizedForLocationUpdatesError()
    }

    private func start() {
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let position = Position.fromLocation(location: location)
            self.delegate.addPosition(position: position)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if self.locationManager.allowsBackgroundLocationUpdates && self.shouldUpdateLocation {
            self.start()
        }
    }

}

protocol LocationGathererDelegate {

    func addPosition(position: Position)

}

class NotAuthorizedForLocationUpdatesError: Error {}
