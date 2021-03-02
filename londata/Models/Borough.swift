//
//  Borough.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import MapKit

struct Borough: Hashable, Equatable, Identifiable {
    let name: String
    let latitude: Double
    let longitude: Double
    let id = UUID()
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
