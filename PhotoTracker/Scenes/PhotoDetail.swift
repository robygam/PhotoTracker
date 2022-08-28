//
//  PhotoDetail.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 27/08/2022.
//

import SwiftUI
import MapKit

struct PhotoDetailLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct PhotoDetail: View {
    var viewModel: ViewModel
    
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
            let mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.location.latitude, longitude: viewModel.location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
            let location = PhotoDetailLocation(name: "", coordinate: CLLocationCoordinate2D(latitude: viewModel.location.latitude, longitude: viewModel.location.longitude))
            Map(coordinateRegion: .constant(mapRegion), interactionModes: [], annotationItems: [location]) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Circle()
                        .strokeBorder(.white, lineWidth: 2)
                        .background(content: {
                            Circle().foregroundColor(.blue)
                            Image(systemName: "camera").foregroundColor(.white)
                        })
                        .frame(width: 44, height: 44)
                    
                }
            }
        }
        .padding(16)
        
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
