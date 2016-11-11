//
//  WebsocketConfig.swift
//  ProjectRide
//
//  Created by Yannick Winter on 11.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation

struct WebsocketConfig: WebsocketConfiguration {

    var url: URL {
        get {
            if let url = URL(string: "wss://locahost/") {
                return url
            }
            fatalError()
        }
    }

}
