//
//  LocationPersistenceController.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation
import CoreLocation
import Combine

struct PersistenceLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
}

class LocationPersistenceController: ObservableObject {
    
    static let shared = LocationPersistenceController()
    
    @Published var locations: [PersistenceLocation] = []
        
    func add(location: CLLocation) {
        // Locations added in the top so they are shown from latests to oldest.
        // I considered adding an extra property like timestamp but didn't to make it simpler.
        locations.insert(PersistenceLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), at: 0)
    }
    
}
