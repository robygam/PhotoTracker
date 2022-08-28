//
//  PhotoCardViewModel.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation
import Combine

extension PhotoCard {
    class ViewModel: StatefullViewModel, ObservableObject {
        @Published var state: ViewState
        @Published var photo: Photo?

        var latitude: Double
        var longitude: Double
        
        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
            
            self.state = .loading
            
            fetchPhoto()
        }
        
        func fetchPhoto() {
            state = .loading
        
            FlickrServices().searchPhotos(latitude: latitude, longitude: longitude) { result in
                switch result {
                case .success(let searchResult):
                    if let photo = searchResult.randomPhoto {
                        self.photo = photo
                        self.state = .ready
                    } else {
                        self.state = .failed(PhotoCard.PhotoError.emptyPhoto)
                    }
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
        }
    }
}

extension PhotoCard {
    enum PhotoError: Error {
        case emptyPhoto
    }
}
