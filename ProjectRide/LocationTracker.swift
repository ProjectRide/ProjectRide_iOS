//
//  LocationTracker.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import CoreLocation
import JSONJoy

class LocationTracker: LocationGathererDelegate {

    private static var instance: LocationTracker?

    static func sharedInstance(connectionManager: WebsocketConnection? = nil) -> LocationTracker {
        guard let instance = self.instance else {
            if let connectionManager = connectionManager {
                self.instance = LocationTracker(websocketConnectionManager: connectionManager)
            } else {
                self.instance = LocationTracker(websocketConnectionManager: WebsocketManager.sharedInstance())
            }
            return self.sharedInstance()
        }
        return instance
    }

    let websocketConnectionManager: WebsocketConnection

    var latestPosition: Position? = nil

    private init(websocketConnectionManager: WebsocketConnection) {
        self.websocketConnectionManager = websocketConnectionManager
    }

    func addPosition(position: Position) {
        self.latestPosition = position
        self.websocketConnectionManager.send(message: position)
    }

}

protocol WebsocketMessageSerializable {

    var type: String { get }
    var messageDictionary: Dictionary<String, Any> { get }

}
