//
//  ErrorView.swift
//  londata
//
//  Created by Nina Rimsky on 03/03/2021.
//

import SwiftUI

struct ErrorView: View {
    
    let onClick: () -> Void

    var body: some View {
        return VStack(alignment: .center) {
            VStack(alignment: .center, spacing: 8) {
                HStack {
                    Image(systemName: "wifi.slash")
                    Text("There was an error fetching data")
                        .font(.callout)
                        .bold()
                }.foregroundColor(.white)
                Text("Please reconnect to the network")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.red)
            Button(action: onClick){
                HStack {
                    Text("Try reloading")
                    Image(systemName: "arrow.clockwise")
                }.padding(.bottom, 10)
            }
        }
        .cornerRadius(8)
        .background(Color.white)
        .cornerRadius(8)
        .overlay (
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1.5)
                .foregroundColor(.red)
        )
        .transition(.scale)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(onClick:{return})
    }
}
