//
//  LocationPersistenceController.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation
import Combine

struct PersistenceLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
}

class LocationPersistenceController: ObservableObject {
    
    static let shared = LocationPersistenceController()
    
    @Published var locations: [PersistenceLocation] = []
    @Published var allowAddingLocations: Bool = false
        
    func add(location: PersistenceLocation) {
        guard allowAddingLocations else { return }
        
        // Locations added in the top so they are shown from latests to oldest.
        // I considered adding an extra property like timestamp but didn't to make it simpler.
        locations.insert(location, at: 0)
    }
    
    func stopAddingLocations() {
        allowAddingLocations = false
    }
    
}
