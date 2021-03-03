//
//  MapInfoAnnotation.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI
import MapKit

struct MapInfoAnnotation: View {
    
    let data: MapMarkerDatapoint
    @Binding var selected: MapMarkerDatapoint?
    
    
    func buttonImage() -> CircleButtonImage {
        switch data {
        case .covid:
            return CircleButtonImage(icon: .covid)
        case .pollution:
            return CircleButtonImage(icon: .pollution)
        }
    }
        
    var body: some View {
        Button(action: {selected = data}, label: buttonImage)
    }
}

struct MapInfoAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        MapInfoAnnotation(data: MapMarkerDatapoint.covid(dataPoint: CovidDatapoint(borough: Borough(name: "Barnet", latitude: 0, longitude: 0), numCases: 2)), selected: .constant(MapMarkerDatapoint.covid(dataPoint: CovidDatapoint(borough: Borough(name: "Barnet", latitude: 0, longitude: 0), numCases: 2))))
    }
}
