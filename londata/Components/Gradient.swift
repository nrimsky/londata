//
//  Gradient.swift
//  londata
//
//  Created by Nina Rimsky on 11/03/2021.
//

import SwiftUI

func color(val: Int?) -> CGColor {
    guard let val = val else {
        return CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    }
    let frac: CGFloat = CGFloat(min(val-1,9))/9.0
    return CGColor(red: frac, green: 0.4*(1-frac), blue: 1.0-frac, alpha: 1.0)
}

struct Gradient: View {

    
    var body: some View {
        VStack(spacing: 0) {
            ForEach((1...10), id: \.self) { maxLevel in
                ZStack {
                    Color(color(val: maxLevel))
                    Text("\(maxLevel)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                }.frame(width: 30, height:30)
                
            }
        }
    }
}

struct Gradient_Previews: PreviewProvider {
    static var previews: some View {
        Gradient()
    }
}
