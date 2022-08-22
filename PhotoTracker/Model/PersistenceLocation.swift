//
//  PersistenceLocation.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 22/08/2022.
//

import Foundation

struct PersistenceLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
}
