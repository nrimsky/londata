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
        case .pollution(let dataPoint):
            return "Pollution data for \(dataPoint.placeName)"
        }
    }
    
    
    func buttonImage() -> CircleButtonImage {
        switch data {
        case .pollution(let dataPoint):
            return CircleButtonImage(icon: .pollution,
                                     val: dataPoint.speciesData.map{$0.qualityIndex}.max())
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
        let species = SpeciesDatapoint(speciesName: "nitrogen dioxide", qualityIndex: 1, qualityDescription: "low")
        let pollutionData = PollutionDatapoint(speciesData: [species], placeName: "London", latitude: 51, longitude: 0)
        let mapData = MapMarkerDatapoint.pollution(dataPoint: pollutionData)
        return MapInfoAnnotation(data: mapData, hapticGenerator: UINotificationFeedbackGenerator(), selected: .constant(mapData))
    }
}
