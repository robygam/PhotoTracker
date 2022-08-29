//
//  PhotoCard.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import SwiftUI
import Combine

struct PhotoCard: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .ready:
                if let photo = viewModel.photo {
                    let detailView = PhotoDetail(viewModel: PhotoDetail.ViewModel(photo: photo))
                    NavigationLink(destination: detailView) {
                        VStack {
                            AsyncImage(url: URL(string: photo.photoURL)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(minWidth: 300, minHeight: 100)
                                        .cornerRadius(12)
                                    Text(photo.title)
                                        .foregroundColor(.black)
                                        .font(.system(size: 13))
                                        .multilineTextAlignment(.center)
                                        .padding()
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
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 0)
                    }
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "photo")
                        Text("Error fetching image")
                    }
                }
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
        PhotoCard(viewModel: PhotoCard.ViewModel(latitude: 42.40364319359173, longitude: -8.81154541729284))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
