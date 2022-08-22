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
        @Published var photoURL: String = String()

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
                    self.photoURL = searchResult.photoURL
                    self.state = .ready
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
        }
    }
}
