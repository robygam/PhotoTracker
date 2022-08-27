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
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PhotoList()
            }
        }
    }
}
