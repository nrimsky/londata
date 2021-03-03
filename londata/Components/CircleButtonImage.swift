//
//  CircleButtonImage.swift
//  londata
//
//  Created by Nina Rimsky on 03/03/2021.
//

import SwiftUI

enum ButtonIcon: String {
    case covid = "person.crop.circle.badge.exclamationmark"
    case pollution = "lungs"
}

struct CircleButtonImage: View {
    
    let icon: ButtonIcon
    
    var color: Color {
        switch icon {
        case .covid:
            return Color.green
        case .pollution:
            return Color.gray
        }
    }
    
    var image: Image {
        switch icon {
        case .covid:
            return Image("CovidIcon")
        case .pollution:
            return Image(systemName: "lungs")
        }
    }
    
    var body: some View {
        image
            .resizable()
            .font(.system(size: 25, weight: .medium))
            .frame(width: 25, height: 25, alignment: .center)
            .foregroundColor(.white)
            .padding(.all, 8)
            .background(color)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.white)
            )
    }
}

struct CircleButtonImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonImage(icon: .covid)
    }
}
