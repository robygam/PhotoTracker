//
//  Photo.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

struct Photo: Codable {
    private let id: String
    private let latitude: String
    private let longitude: String
    let photoURL: String
    let title: String
    
    var lat: Double {
        Double(latitude) ?? 0.0
    }
    
    var lon: Double {
        Double(longitude) ?? 0.0
    }
    
    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude, title
        case photoURL = "url_m"
    }
    
    init(id: String = UUID().uuidString, latitude: Double, longitude: Double, photoURL: String, title: String) {
        self.id = id
        self.latitude = String(latitude)
        self.longitude = String(longitude)
        self.photoURL = photoURL
        self.title = title
    }
}

extension Photo: Equatable {
    /// In order to be same photo it's just needed to have same url
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoURL == rhs.photoURL
    }
}
