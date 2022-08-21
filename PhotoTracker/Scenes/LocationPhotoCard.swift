//
//  LocationPhotoCard.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import SwiftUI
import Combine

struct LocationPhotoCard: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .ready:
                VStack {
                    AsyncImage(url: URL(string: viewModel.photoURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 300, minHeight: 100)
                                .cornerRadius(12)
                        case .failure:
                            HStack(spacing: 8) {
                                Image(systemName: "photo")
                                Text("Error fetching image")
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 0)
            case .failed:
                HStack(spacing: 8) {
                    Image(systemName: "photo")
                    Text("Error fetching image")
                }
            }
                          
        }
    }
}

struct LocationPhotoCard_Previews: PreviewProvider {
    static var previews: some View {
        LocationPhotoCard(viewModel: LocationPhotoCard.ViewModel(latitude: 30, longitude: -122))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

extension LocationPhotoCard {
    class ViewModel: StatefullViewModel, ObservableObject {
        @Published var state: ViewState
        @Published var photoURL: String = String() {
            didSet {
                didChange.send(self)
            }
        }

        var latitude: Double
        var longitude: Double
        
        let didChange = PassthroughSubject<LocationPhotoCard.ViewModel, Never>()

        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
            
            self.state = .loading
            
            fetchPhoto()
        }
        
        func fetchPhoto() {
            state = .loading
        
            FlickrServices().searchPhotos(latitude: latitude, longitude: longitude) { result in
                switch result {
                case .success(let searchResult):
                    self.photoURL = searchResult.photoURL
                    self.state = .ready
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
        }
    }
}
