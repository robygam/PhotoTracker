//
//  PhotoDetail.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 27/08/2022.
//

import SwiftUI

struct PhotoDetail: View {
    var viewModel: ViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhotoDetail_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetail(viewModel: PhotoDetail.ViewModel(url: "", location: PersistenceLocation(latitude: 0.0, longitude: 0.0)))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

extension PhotoDetail {
    struct ViewModel {
        let url: String
        let location: PersistenceLocation
    }
}
