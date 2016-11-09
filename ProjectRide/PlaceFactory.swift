//
//  PlaceFactory.swift
//  ProjectRide
//
//  Created by Yannick Winter on 08.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceFactory {

    static func createPlaceWithCoordinate(coordinate: CLLocationCoordinate2D, completion: @escaping ((Place?) -> Void) ) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let locality = placemark?.first?.locality, let postalCode = placemark?.first?.postalCode {
                let uuid = NSUUID().uuidString
                let place = Place(id: uuid, latitude: coordinate.latitude, longitude: coordinate.longitude, name: locality, postcode: postalCode)
                completion(place)
                return
            }
            completion(nil)
        }
    }

}
