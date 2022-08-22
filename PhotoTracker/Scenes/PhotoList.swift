//
//  PhotoList.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import SwiftUI
import Combine

struct PhotoList: View {
    @ObservedObject var persistenceController = LocationPersistenceController.shared
    
    var body: some View {
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
                print("Pause")
            }) {
                Text("Pause")
            }
        }.onAppear {
            LocationPublisher.shared.requestLocationUpdates()
        }
    }
}

struct PhotoList_Previews: PreviewProvider {
    
    static var previews: some View {
        PhotoList()
    }
    
}
