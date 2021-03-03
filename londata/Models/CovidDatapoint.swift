//
//  CovidDatapoint.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import MapKit

struct CovidDatapoint: Equatable, Identifiable {
    let id = UUID()
    let borough: Borough
    let numCases: Int
}
