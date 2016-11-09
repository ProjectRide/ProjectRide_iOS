//
//  ApiConfigImpl.swift
//  ProjectRide
//
//  Created by Yannick Winter on 09.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation

class ApiConfigImpl: ApiConfig {

    var baseURL: String = ""

    init(baseURL: String) {
        self.baseURL = self.formatBaseURL(baseURL: baseURL)
    }

    fileprivate func formatBaseURL(baseURL: String) -> String {
        var formattedURL = baseURL
        if baseURL.characters.last != "/" {
            formattedURL = "\(baseURL)/"
        }
        return formattedURL
    }


}
