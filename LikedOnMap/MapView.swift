//
//  MapView.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    let currentLocation: MKCoordinateRegion
    let annotations: [Point]

    static let clusterReuseId = "ClusterView"
    static let annotationReuseId = "SingleView"

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.setRegion(currentLocation, animated: false)
        map.mapType = .hybrid
        map.delegate = context.coordinator
        map.isRotateEnabled = false

        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MapView.annotationReuseId)
        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MapView.clusterReuseId)

        map.addAnnotations(annotations)

        return map
    }

    func updateUIView(_ mapView: MKMapView, context: Context) { }

    func makeCoordinator() -> MapCoordinator {
        MapCoordinator()
    }

    final class MapCoordinator: NSObject, MKMapViewDelegate {

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            switch annotation {

            case let point as Point:
                let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: MapView.annotationReuseId, for: annotation) as? MKMarkerAnnotationView
                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MapView.annotationReuseId)

                annotation.glyphText = point.status.associatedSymbol
                annotation.markerTintColor = point.status.associatedColor
                annotation.clusteringIdentifier = point.status.rawValue
                annotation.titleVisibility = .visible
                annotation.subtitleVisibility = .hidden
                annotation.animatesWhenAdded = false

                switch point.status {
                case .disabled:
                    annotation.displayPriority = .defaultLow
                case .liked:
                    annotation.displayPriority = .required
                case .active:
                    annotation.displayPriority = .defaultHigh
                case .blocked:
                    annotation.displayPriority = .defaultLow
                }

                return annotation

            case let cluster as MKClusterAnnotation:

                let clusterStatus = (cluster.memberAnnotations.first as? Point)?.status

                let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: MapView.clusterReuseId) as? MKMarkerAnnotationView
                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MapView.clusterReuseId)

                annotation.markerTintColor = clusterStatus?.associatedColor ?? .clear
                annotation.clusteringIdentifier = clusterStatus?.rawValue ?? ""
                annotation.glyphText = "\(cluster.memberAnnotations.count)"
                annotation.titleVisibility = .visible
                annotation.subtitleVisibility = .hidden
                annotation.animatesWhenAdded = false

                switch clusterStatus {
                case .disabled:
                    annotation.displayPriority = .defaultLow
                case .liked:
                    annotation.displayPriority = .required
                case .active:
                    annotation.displayPriority = .defaultHigh
                case .blocked:
                    annotation.displayPriority = .defaultLow
                case .none:
                    annotation.displayPriority = .defaultLow
                }

                return annotation

            default: return nil
            }
        }

    }

}
