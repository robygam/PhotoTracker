//
//  FlickrAPI.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

class FlickrAPI: APIClient {
    static let shared: FlickrAPI = {
        let baseURL = "https://www.flickr.com/services/rest/"

        return FlickrAPI(baseURL: baseURL)
    }()

    private static let authKey = "cca6353245fc53a3e1de19555377ddd9"

    override var defaultAuth: AuthMethod {
        return AuthMethod.urlAccessKey(key: "api_key", value: FlickrAPI.authKey)
    }
}
