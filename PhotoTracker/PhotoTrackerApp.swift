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
        LocationPublisher.shared.coordinatesPublisher.sink(receiveValue: LocationPersistenceController.shared.add).store(in: &cancellables)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PhotoList()
            }
        }
    }
}
