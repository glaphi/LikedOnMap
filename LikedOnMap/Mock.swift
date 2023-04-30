//
//  Mock.swift
//  LikedOnMap
//
//  Created by Glafira on 8.5.2022.
//

import Foundation
import UIKit

fileprivate let decoder = JSONDecoder()

func loadData() -> [Point] {

    struct PointEnvelop: Decodable {
        let points: [Point?]
    }

    guard
        let data = NSDataAsset(name: "points", bundle: Bundle.main)?.data,
        let envelop = try? decoder.decode(PointEnvelop.self, from: data)
    else {
        return []
    }

    return envelop.points.compactMap { $0 }
}
