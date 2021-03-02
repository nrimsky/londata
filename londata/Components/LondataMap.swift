//
//  LondataMap.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI

import SwiftUI
import MapKit

struct LondataMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.5))
    
    @Binding var pollutionData: [LocalAuthorityData]
    @Binding var covidCases: [Borough: Int]

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: covidCases.map{$0.key}) { borough in
            MapMarker(coordinate: borough.coordinate)
        }.ignoresSafeArea(.all, edges: .all)
    }
}

struct LondataMap_Previews: PreviewProvider {
    static var previews: some View {
        LondataMap(pollutionData: .constant([LocalAuthorityData]()), covidCases: .constant([Borough: Int]()))
    }
}
