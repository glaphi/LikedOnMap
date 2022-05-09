//
//  LikedOnMapApp.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import SwiftUI
import MapKit

@main
struct LikedOnMapApp: App {

    @StateObject
    private var locationManager = LocationManager()

    private let annotations = loadData()

    var body: some Scene {
        WindowGroup {
            if let currentLocation = locationManager.currentLocation {
                Map(
                    currentLocation: currentLocation,
                    annotations: annotations
                )
            } else {
                switch locationManager.authorisationStatus {
                case .restricted, .denied:
                    Text("Please allow location access")
                case .authorizedAlways, .authorizedWhenInUse, .authorized, .notDetermined:
                    Spinner()
                @unknown default:
                    Spinner()
                }
            }
        }
    }
}
