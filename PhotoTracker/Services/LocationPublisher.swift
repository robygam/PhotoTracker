//
//  LocationPublisher.swift
//  PhotoTracker
//
//  Created by Roberto Garcia on 20/08/2022.
//

import Foundation
import Combine
import CoreLocation

class LocationPublisher: NSObject, ObservableObject {

    var coordinatesPublisher = PassthroughSubject<PersistenceLocation, Never>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()
    
    fileprivate var previousLocation: CLLocation?
    fileprivate static let distanceThreshold: Double = 100.0
    fileprivate var elapsedDistance: Double = 0
    
    @Published private(set) var isLocationUpdating: Bool = false

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.activityType = .otherNavigation
        manager.allowsBackgroundLocationUpdates = true

        return manager
    }()

    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            locationManager.stopUpdatingLocation()
            deniedLocationAccessPublisher.send()
        }
    }
    
    func toggleLocationUpdate() {
        if isLocationUpdating {
            stopUpdatingLocation()
        } else {
            requestLocationUpdates()
        }
        isLocationUpdating = !isLocationUpdating
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    fileprivate func compareLocationWithPrevious(_ location: CLLocation) {
        guard let previousLocation = previousLocation else {
            publishLocationAndSave(location)
            return
        }

        // We are interested in elapsed distance
        elapsedDistance += previousLocation.distance(from: location)
        if elapsedDistance >= LocationPublisher.distanceThreshold {
            elapsedDistance = 0
            publishLocationAndSave(location)
        }
    }
    
    fileprivate func publishLocationAndSave(_ location: CLLocation) {
        previousLocation = location
        coordinatesPublisher.send(PersistenceLocation(location))
    }
}

extension LocationPublisher: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            isLocationUpdating = true
        default:
            manager.stopUpdatingLocation()
            isLocationUpdating = false
            deniedLocationAccessPublisher.send()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        compareLocationWithPrevious(location)
    }
}

extension PersistenceLocation {
    init(_ location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}
