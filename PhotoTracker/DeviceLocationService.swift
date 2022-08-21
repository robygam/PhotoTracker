//
//  LocationController.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import Foundation
import Combine
import CoreLocation

class DeviceLocationService: NSObject, CLLocationManagerDelegate, ObservableObject {

    var coordinatesPublisher = PassthroughSubject<CLLocation, Never>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()

    static let shared = DeviceLocationService()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()

    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        default:
            manager.stopUpdatingLocation()
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinatesPublisher.send(location)
    }
}
