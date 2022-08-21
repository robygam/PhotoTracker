//
//  ContentView.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    // 1
    @StateObject var deviceLocationService = DeviceLocationService.shared

    // 2
    @State var tokens: Set<AnyCancellable> = []

    // 3
    @State var coordinates: (lat: Double, lon: Double) = (0, 0)
    
    var body: some View {
        // 1
        VStack {
            Text("Latitude: \(coordinates.lat)")
                .font(.largeTitle)
            Text("Longitude: \(coordinates.lon)")
                .font(.largeTitle)
        }
        // 2
        .onAppear {
            observeCoordinateUpdates()
            observeDeniedLocationAccess()
            deviceLocationService.requestLocationUpdates()
        }
    }
    
    // 1
    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                self.coordinates = (coordinates.latitude, coordinates.longitude)
            }
            .store(in: &tokens)
    }

    // 2
    func observeDeniedLocationAccess() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
            }
            .store(in: &tokens)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
