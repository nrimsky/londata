//
//  MapMarker.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import MapKit

enum MapMarkerDatapoint: Equatable {
    
    case pollution(dataPoint: PollutionDatapoint)
    
    static func == (lhs: MapMarkerDatapoint, rhs: MapMarkerDatapoint) -> Bool {
        switch lhs {
        case .pollution(let dataPoint1):
            switch rhs {
            case .pollution(let dataPoint2):
                return dataPoint1 == dataPoint2
            }
        }
    }
    
}

struct MapMarker: Identifiable {
    
    var id: UUID
    
    let data: MapMarkerDatapoint
    let coordinate: CLLocationCoordinate2D
    
    init(pollutionData: PollutionDatapoint) {
        data = .pollution(dataPoint: pollutionData)
        id = pollutionData.id
        coordinate = pollutionData.coordinate
    }
}
