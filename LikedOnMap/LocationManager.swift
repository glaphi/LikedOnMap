//
//  LocationManager.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject {

    @Published
    var authorisationStatus: CLAuthorizationStatus = .notDetermined

    @Published
    var currentLocation: CLLocation?

    private let locationManager = CLLocationManager()

    override init() {
        super.init()

        self.locationManager.delegate = self

        locationManager.requestAlwaysAuthorization()
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status

        if authorisationStatus == .authorizedAlways || authorisationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }

}
