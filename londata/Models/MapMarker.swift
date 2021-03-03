//
//  MapMarker.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import MapKit

enum MapMarkerDatapoint {
    case covid(dataPoint: CovidDatapoint)
    case pollution(dataPoint: PollutionDatapoint)
}

struct MapMarker: Identifiable, Equatable {
    
    var id: UUID
    
    static func == (lhs: MapMarker, rhs: MapMarker) -> Bool {
        switch lhs.data {
        case .covid(let dataPoint1):
            switch rhs.data {
            case .covid(let dataPoint2):
                return dataPoint1 == dataPoint2
            case .pollution:
                return false
            }
        case .pollution(let dataPoint1):
            switch rhs.data {
            case .covid:
                return false
            case .pollution(let dataPoint2):
                return dataPoint1 == dataPoint2
            }
        }
    }
    
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
