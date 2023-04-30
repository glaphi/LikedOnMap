//
//  Map.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import SwiftUI
import MapKit

struct Map: View {

    private var annotations: [Point]

    @State
    private var region: MKCoordinateRegion

    init(currentLocation: CLLocation, annotations: [Point]) {
        self.annotations = annotations

        _region = State(
            initialValue: MKCoordinateRegion(
                center: currentLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }

    var body: some View {
        MapView(currentLocation: region, annotations: annotations)
            .edgesIgnoringSafeArea(.all)
    }

}
