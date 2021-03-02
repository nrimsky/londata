//
//  CovidIndicator.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI

struct CovidIndicator: View {
    let numCases: Int
    let areaName: String
    var body: some View {
        VStack {
            Text(areaName)
                .foregroundColor(.purple)
                .bold()
                .font(.system(size: 10))
            Text("\(numCases) new cases")
                .foregroundColor(.purple)
                .font(.system(size: 14))
        }
        .padding(5)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .background(Color.white)
        .shadow(radius: 5)
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 1))
        
    }
}

struct CovidIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CovidIndicator(numCases: 5, areaName: "Barnet")
    }
}
