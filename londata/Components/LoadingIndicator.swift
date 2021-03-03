//
//  LoadingIndicator.swift
//  londata
//
//  Created by Nina Rimsky on 03/03/2021.
//

import Foundation
import SwiftUI

struct LoadingIndicator: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<LoadingIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingIndicator>) {
        uiView.startAnimating()
    }
}
