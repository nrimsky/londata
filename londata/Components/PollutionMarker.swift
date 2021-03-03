//
//  PollutionMarker.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI

struct PollutionMarker: View {
    
    let pollutionDatapoint: PollutionDatapoint
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("📍Air quality measured: \(pollutionDatapoint.placeName)")
                .fontWeight(.bold)
                .foregroundColor(Color.red)
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("💨Species")
                        .font(.caption)
                        .fontWeight(.semibold)
                    ForEach(pollutionDatapoint.speciesData, id: \.speciesName) { species in
                        Text("\(species.speciesName)")
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("📊Quality index")
                        .font(.caption)
                        .fontWeight(.semibold)
                    ForEach(pollutionDatapoint.speciesData, id: \.speciesName) { species in
                        Text(" \(species.qualityIndex)")
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("🎚Level")
                        .font(.caption)
                        .fontWeight(.semibold)
                    ForEach(pollutionDatapoint.speciesData, id: \.speciesName) { species in
                        Text(" \(species.qualityDescription)")
                    }
                }
                
            }
        }.padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.blue))
    }
}

struct PollutionMarker_Previews: PreviewProvider {
    static var previews: some View {
        PollutionMarker(pollutionDatapoint: PollutionDatapoint(speciesData: [SpeciesDatapoint(speciesName: "Nitrogen dioxide", qualityIndex: 2, qualityDescription: "Low"), SpeciesDatapoint(speciesName: "Nitrogen dioxide", qualityIndex: 2, qualityDescription: "Low")], placeName: "Highgate", latitude: 1, longitude: 1))
    }
}
