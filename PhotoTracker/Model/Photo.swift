//
//  Photo.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

struct Photo: Codable {
    let id: String
    let latitude: String
    let longitude: String
    let photoURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude
        case photoURL = "url_m"
    }
}
