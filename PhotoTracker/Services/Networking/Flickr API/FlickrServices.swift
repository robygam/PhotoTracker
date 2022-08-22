//
//  FlickrServices.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

protocol FlickrContentService {
    func searchPhotos(latitude: Double, longitude: Double, completion: @escaping ((Result<SearchResponse, Error>) -> Void))
}

struct SearchResponse: Codable {
    let photos: FlickrPhotos
    let stat: String
    
    var photoURL: String {
        photos.photoList.first?.photoURL ?? ""
    }
}

struct FlickrPhotos: Codable {
    let photoList: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photoList = "photo"
    }
}

class FlickrServices: FlickrContentService {
    let dataProvider: DataProvider
    
    init(dataProvider: DataProvider = DataProvider(provider: FlickrAPI.shared)) {
        self.dataProvider = dataProvider
    }
    
    func searchPhotos(latitude: Double, longitude: Double, completion: @escaping ((Result<SearchResponse, Error>) -> Void)) {
        let parameters: [String: Any] = ["method": "flickr.photos.search",
                                         "lat": latitude,
                                         "lon": longitude,
                                         "format": "json",
                                         "nojsoncallback": 1,
                                         "per_page": 1,
                                         "extras": "geo, url_m"]
        
        dataProvider.request(parameters: parameters, method: .get) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
