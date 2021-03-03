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
    let hapticGenerator: UINotificationFeedbackGenerator
    @Binding var selected: MapMarkerDatapoint?
    
    func select() {
        selected = data
        hapticGenerator.notificationOccurred(.success)
    }
    
    func overlayView() -> AnyView {
        guard let s = selected else { return AnyView(EmptyView()) }
        if (data == s) {
            return AnyView(Circle()
                            .stroke(lineWidth: 4)
                            .foregroundColor(.yellow))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    var textDescription: String {
        switch data {
        case .covid(let dataPoint):
            return "Coronavirus data for \(dataPoint.borough.name)"
        case .pollution(let dataPoint):
            return "Pollution data for \(dataPoint.placeName)"
        }
    }
    
    
    func buttonImage() -> CircleButtonImage {
        switch data {
        case .covid:
            return CircleButtonImage(icon: .covid)
        case .pollution:
            return CircleButtonImage(icon: .pollution)
        }
    }
        
    var body: some View {
        Button(action: select, label: buttonImage).overlay(
            overlayView()
        ).accessibilityLabel(Text(textDescription))
    }
}

struct MapInfoAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        MapInfoAnnotation(data: MapMarkerDatapoint.covid(dataPoint: CovidDatapoint(borough: Borough(name: "Barnet", latitude: 0, longitude: 0), numCases: 2)), hapticGenerator: UINotificationFeedbackGenerator(), selected: .constant(MapMarkerDatapoint.covid(dataPoint: CovidDatapoint(borough: Borough(name: "Barnet", latitude: 0, longitude: 0), numCases: 2))))
    }
}
