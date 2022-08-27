//
//  PhotoDetail.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 27/08/2022.
//

import SwiftUI
import MapKit

struct PhotoDetail: View {
    var viewModel: ViewModel
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900,
                                           longitude: -122.009_020),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.imageURL)) { phase in
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
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.location.latitude, longitude: viewModel.location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))), interactionModes: [])
                .frame(width: 400, height: 300)
        }
        .padding()
        
    }
}

struct PhotoDetail_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetail(viewModel: PhotoDetail.ViewModel(imageURL: "https://sp-ao.shortpixel.ai/client/q_lossy,ret_img,w_600/https://www.senderismoeuropa.com/wp-content/uploads/2014/10/trekking-senderismo-hiking-excursionismo2-600x399.jpg", location: PersistenceLocation(latitude: 42.40364319359173, longitude: -8.81154541729284)))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

extension PhotoDetail {
    struct ViewModel {
        let imageURL: String
        let location: PersistenceLocation
    }
}
