//
//  PhotoTrackerApp.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import SwiftUI
import Combine

@main
struct PhotoTrackerApp: App {
    var cancellables = [AnyCancellable]()
    
    init() {
        let persistenceController = LocationPersistenceController.shared
        LocationPublisher.shared.coordinatesPublisher.sink(receiveValue: persistenceController.add).store(in: &cancellables)
        LocationPublisher.shared.deniedLocationAccessPublisher.sink(receiveValue: persistenceController.stopAddingLocations).store(in: &cancellables)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PhotoList()
            }
        }
    }
}
