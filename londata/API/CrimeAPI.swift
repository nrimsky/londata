//
//  CrimeAPI.swift
//  londata
//
//  Created by Nina Rimsky on 27/02/2021.
//

import Foundation
import MapKit
import Combine

struct CrimeAPI {
    static let agent = Agent()
    static let base = URL(string: "https://data.police.uk/api/crimes-street/all-crime")!
}

extension CrimeAPI {
    
    static func crimes(location: CLLocationCoordinate2D) -> AnyPublisher<[StreetCrime], Error> {
        let request = URLRequest(url:base
            .appendingPathComponent(
                "?lat=\(location.latitude)&lng=\(location.longitude)"
            )
        )
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}



struct StreetCrime: Codable {
    let category: String
    let location: CrimeLocation
}

struct CrimeLocation: Codable {
    let latitude: StringBacked<Double>
    let longitude: StringBacked<Double>
    
    var lat: Double {
        get { return latitude.value }
    }
    var lon: Double {
        get { return longitude.value }
    }
}
