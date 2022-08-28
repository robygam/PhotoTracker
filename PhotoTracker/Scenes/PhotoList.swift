//
//  PhotoList.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import SwiftUI
import Combine

struct PhotoList: View {
    @ObservedObject var locationPublisher = LocationPublisher()
    @ObservedObject var persistenceController = LocationPersistenceController()
    var cancellables = [AnyCancellable]()

    init() {
        locationPublisher.coordinatesPublisher.sink(receiveValue: persistenceController.add).store(in: &cancellables)
        locationPublisher.deniedLocationAccessPublisher.sink(receiveValue: locationPublisher.stopUpdatingLocation).store(in: &cancellables)
    }
    
    var body: some View {
        if persistenceController.locations.isEmpty, !locationPublisher.isLocationUpdating {
            Button("Start Tracking") {
                locationPublisher.toggleLocationUpdate()
            }
            .font(.system(size: 15, weight: .medium))
            .frame(width: 150, height: 50, alignment: .center)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        } else {
            List {
                ForEach(persistenceController.locations) { location in
                    PhotoCard(viewModel: PhotoCard.ViewModel(latitude: location.latitude, longitude: location.longitude))
                        .listRowSeparator(.hidden)
                        .frame(minWidth: 300, minHeight: 50, alignment: .center)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    locationPublisher.toggleLocationUpdate()
                }, label: {
                    Text(locationPublisher.isLocationUpdating ? "Stop" : "Start")
                })
            }
        }
    }
}

struct PhotoList_Previews: PreviewProvider {
    
    static var previews: some View {
        PhotoList()
    }
    
}
