//
//  AboutScreen.swift
//  londata
//
//  Created by Nina Rimsky on 03/03/2021.
//

import SwiftUI

import SwiftUI

struct AboutScreen: View {
    
    @Environment(\.presentationMode) var presentationMode

    let text = """
    OpenUrban CIC is a London based nonprofit developing Open Data based apps and digital tools.
    The aim of this app is to enable you to explore and interact with London-related Open Data feeds.
    """
    
    let air_source = """
    Air quality data is obtained from the Environmental Research Group of Kings College
    London (http://www.erg.kcl.ac.uk), using data from the London Air Quality Network
    (http://www.londonair.org.uk). This data is licensed under the terms of the Open
    Government Licence.
    """
    
    func openOpenUrbanWesbite() {
        let urlStr = "https://openurban.org.uk/"
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url)
    }
    
    func close() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("👋 The LonData app is developed and maintained by OpenUrban CIC")
                        .font(.headline)
                    Text(text)
                    Button(action: openOpenUrbanWesbite) {
                        HStack {
                            Image(systemName: "arrow.up.right")
                            Text("More about OpenUrban CIC on our website")
                        }
                    }
                    Text("📊 Data sources")
                        .font(.headline)
                    Text(air_source)
                }.padding(15)
            }
            .navigationBarTitle("About LonData", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: close) {
                Text("Close")
            })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
