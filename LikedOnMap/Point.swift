//
//  Point.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import Foundation
import UIKit
import MapKit

final class Point: NSObject, MKAnnotation, Decodable, Identifiable {
    let id = UUID()

    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let status: Status

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case status
    }
}

enum Status: String, Decodable {
    case disabled
    case liked
    case active
    case blocked

    var associatedColor: UIColor {
        switch self {
        case .disabled:
            return .gray
        case .liked:
            return .magenta
        case .active:
            return .green
        case .blocked:
            return .red
        }
    }

    var associatedSymbol: String {
        switch self {
        case .disabled:
            return "×"
        case .liked:
            return "♥"
        case .active:
            return "♦"
        case .blocked:
            return "⬣"
        }
    }

}
