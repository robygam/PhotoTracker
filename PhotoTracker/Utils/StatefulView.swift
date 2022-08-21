//
//  StatefulView.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 21/08/2022.
//

import Foundation

protocol StatefullViewModel: ObservableObject {
    var state: ViewState { get set }
}

enum ViewState {
    case loading
    case ready
    case failed(_: Error)
}
