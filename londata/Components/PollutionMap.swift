//
//  PollutionMap.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI
import MapKit

struct PollutionMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.5))
    
    @Binding var pollutionData: [PollutionDatapoint]

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: pollutionData) { pollutionDatapoint in
            MapAnnotation(coordinate: pollutionDatapoint.coordinate) {
                PollutionIndicator(text: pollutionDatapoint.placeName)
            }
        }.ignoresSafeArea(.all, edges: .all)
    }
}

struct PollutionMap_Previews: PreviewProvider {
    static var previews: some View {
        PollutionMap(pollutionData: .constant([PollutionDatapoint]()))
    }
}
