//
//  DataMap.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI
import MapKit

struct DataMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.5))
    
    @Binding var mapMarkers: [MapMarker]
    @State var selected: MapMarkerDatapoint? = nil
    
    func infoView() -> AnyView {
        guard let data = selected else {
            return AnyView(EmptyView())
        }
        switch data {
        case .covid(dataPoint: let covidDatapoint):
            return AnyView(CovidMarker(covidDatapoint: covidDatapoint))
        case .pollution(dataPoint: let pollutionDatapoint):
            return AnyView(PollutionMarker(pollutionDatapoint: pollutionDatapoint))
        }
    }
    

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: mapMarkers) { mapMarker in
                MapAnnotation(coordinate: mapMarker.coordinate) {
                    MapInfoAnnotation(data: mapMarker.data, selected: $selected)
                }
            }.ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                infoView().padding(30)
            }
        }
    }
}

struct DataMap_Previews: PreviewProvider {
    static var previews: some View {
        DataMap(mapMarkers: .constant([MapMarker]()))
    }
}
