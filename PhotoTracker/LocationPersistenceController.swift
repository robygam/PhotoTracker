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
    let timestamp = Date()
}

class LocationPersistenceController: ObservableObject {
    
    static let shared = LocationPersistenceController()
    
    @Published var locations: [PersistenceLocation] = []
        
    func add(location: CLLocation) {
        locations.append(PersistenceLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
}
