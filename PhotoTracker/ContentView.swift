//
//  ContentView.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var persistenceController = LocationPersistenceController.shared
    
    var body: some View {
        ZStack {
            List {
                ForEach(persistenceController.locations) { location in
                    Text("Lat: \(location.latitude), Lon: \(location.longitude)")
//                    LocationPhotoCard(viewModel: LocationPhotoCard.ViewModel(latitude: location.latitude, longitude: location.longitude))
                        .listRowSeparator(.hidden)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                print("Pause")
            }) {
                Text("Pause")
            }
        }.onAppear {
            DeviceLocationService.shared.requestLocationUpdates()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
