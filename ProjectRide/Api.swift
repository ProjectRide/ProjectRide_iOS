//
//  Api.swift
//  ProjectRide
//
//  Created by Yannick Winter on 08.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import Foundation
import Alamofire
import JSONJoy

protocol Api {

    init(apiConfig: ApiConfig)
    var apiConfig: ApiConfig { get set }

}

extension Api {

    func fetch(entityName: String, completion: @escaping ((JSONDecoder?, Error?) -> Void)) {
        let url = self.urlForEntity(entity: entityName)
        Alamofire.request(url).response() { response in
            let fetchHandler = FetchResponseHandler(response: response.response, data: response.data, error: response.error)
            do {
                let jsonDecoder = try fetchHandler.handle()
                completion(jsonDecoder, nil)
            } catch {
                completion(nil, error)
            }
        }
    }

    private func urlForEntity(entity: String) -> String {
        return "\(self.apiConfig.baseURL)\(entity)"
    }

}
