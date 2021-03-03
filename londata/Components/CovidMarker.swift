//
//  CovidMarker.swift
//  londata
//
//  Created by Nina Rimsky on 03/03/2021.
//

import SwiftUI

struct CovidMarker: View {
    
    let covidDatapoint: CovidDatapoint
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("🦠 Covid data for \(covidDatapoint.borough.name)")
                .foregroundColor(Color.blue).bold()
            HStack(spacing: 10) {
                Text("New Covid cases yesterday:")
                Text("\(covidDatapoint.numCases)")
                    .fontWeight(.semibold)
            }
        }.padding(10)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.blue))
        
    }
}

struct CovidAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CovidMarker(covidDatapoint: CovidDatapoint(borough: Borough(name: "Barnet", latitude: 0, longitude: 0), numCases: 2))
    }
}
