//
//  MapMarker.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import MapKit

enum MapMarkerDatapoint: Equatable {
    
    case covid(dataPoint: CovidDatapoint)
    case pollution(dataPoint: PollutionDatapoint)
    
    static func == (lhs: MapMarkerDatapoint, rhs: MapMarkerDatapoint) -> Bool {
        switch lhs {
        case .covid(let dataPoint1):
            switch rhs {
            case .covid(let dataPoint2):
                return dataPoint1 == dataPoint2
            case .pollution:
                return false
            }
        case .pollution(let dataPoint1):
            switch rhs {
            case .covid:
                return false
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
    
    init(covidData: CovidDatapoint) {
        data = .covid(dataPoint: covidData)
        id = covidData.id
        coordinate = covidData.borough.coordinate
    }
    init(pollutionData: PollutionDatapoint) {
        data = .pollution(dataPoint: pollutionData)
        id = pollutionData.id
        coordinate = pollutionData.coordinate
    }
}
