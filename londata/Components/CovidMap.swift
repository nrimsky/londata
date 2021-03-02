//
//  CovidMap.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI

import SwiftUI
import MapKit

struct CovidMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.5))
    @Binding var covidCases: [Borough: Int]

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: covidCases.map{$0.key}) { borough in
            MapAnnotation(coordinate: borough.coordinate) {
                CovidIndicator(numCases: covidCases[borough] ?? 0, areaName: borough.name)
            }
        }.ignoresSafeArea(.all, edges: .all)
    }
}

struct LondataMap_Previews: PreviewProvider {
    static var previews: some View {
        CovidMap(covidCases: .constant([Borough: Int]()))
    }
}
