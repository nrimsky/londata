//
//  PlaceNames.swift
//  londata
//
//  Created by Nina Rimsky on 27/02/2021.
//

import Foundation
import MapKit

enum PlaceNames {
    static let BOROUGHS: [String: (Double, Double)] = [
                "Barking and Dagenham": (51.5607,  0.1557),
                "Barnet": (51.6252,  0.1517),
                "Bexley": (51.4549,  -0.1505),
                "Brent": (51.5588,  0.2817),
                "Bromley": (51.4039,  -0.0198),
                "Camden": (51.5290,  -0.1255),
                "Croydon": (51.3714,  -0.0977),
                "Ealing": (51.5130,  -0.3089),
                "Enfield": (51.6538,  -0.0799),
                "Greenwich": (51.4892,  0.0648),
                "Hackney and City of London": (51.5450,  -0.0553),
                "Hammersmith and Fulham": (51.4927,  -0.2339),
                "Haringey": (51.6000,  -0.1119),
                "Harrow": (51.5898,  -0.3346),
                "Havering": (51.5812,  0.1837),
                "Hillingdon": (51.5441,  -0.4760),
                "Hounslow": (51.4746,  -0.3680),
                "Islington": (51.5416, -0.1022),
                "Kensington and Chelsea": (51.5020, -0.1947),
                "Kingston upon Thames": (51.4085, -0.3064),
                "Lambeth": (51.4607, -0.1163),
                "Lewisham": (51.4452, -0.0209),
                "Merton": (51.4014, -0.1958),
                "Newham": (51.5077, 0.0469),
                "Redbridge": (51.5590, 0.0741),
                "Richmond upon Thames": (51.4479, -0.3260),
                "Southwark": (51.3618, -0.1945),
                "Sutton": (51.3618, -0.1945),
                "Tower Hamlets": (51.5099, -0.0059),
                "Waltham Forest": (51.5908, -0.0134),
                "Wandsworth": (51.4567, -0.1910),
                "Westminster": (51.4973, -0.1372)]
    
}

struct Borough: Hashable, Equatable, Identifiable {
    let name: String
    let latitude: Double
    let longitude: Double
    let id = UUID()
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}


