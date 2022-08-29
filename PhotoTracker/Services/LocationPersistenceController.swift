//
//  LocationPersistenceController.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation
import Combine

class LocationPersistenceController: ObservableObject {
        
    @Published var locations: [PersistenceLocation] = []
        
    func add(location: PersistenceLocation) {
        // Locations added in the top so they are shown from latests to oldest.
        locations.insert(location, at: 0)
    }
}
