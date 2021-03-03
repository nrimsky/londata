//
//  PollutionDatapoint.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import MapKit

struct SpeciesDatapoint: Equatable {
    let speciesName: String
    let qualityIndex: Int
    let qualityDescription: String
}

struct PollutionDatapoint: Equatable, Identifiable {
    let speciesData: [SpeciesDatapoint]
    let placeName: String
    let latitude: Double
    let longitude: Double
    let id = UUID()
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
