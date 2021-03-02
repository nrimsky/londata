//
//  PollutionIndicator.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import SwiftUI

struct PollutionIndicator: View {
    let text: String
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "smoke.fill")
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .padding(5)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
            Text(text)
        }
    }
}

struct PollutionIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PollutionIndicator(text: "high pollution")
    }
}
