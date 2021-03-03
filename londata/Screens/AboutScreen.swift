//
//  AboutScreen.swift
//  londata
//
//  Created by Nina Rimsky on 03/03/2021.
//

import SwiftUI

import SwiftUI

struct AboutScreen: View {
    
    @State var showShareSheet: Bool = false

    
    let text = """
    OpenUrban CIC is a London based nonprofit developing Open Data based apps and digital tools.
    The aim of this app is to enable you to explore and interact with London-related Open Data feeds. The app can also help you make informed decisions about where to go running, cycling or walking in London.
    We are planning to include more data sources and interesting London statistics into the app.
    """
    
    let air_source = """
    Air quality data is obtained from the Environmental Research Group of Kings College
    London (http://www.erg.kcl.ac.uk), using data from the London Air Quality Network
    (http://www.londonair.org.uk). This data is licensed under the terms of the Open
    Government Licence.
    """
    
    let covid_source = """
    Covid data comes from the government's UK Coronavirus API and is available under the Open Government Licence v3.0.
    """
    
//    let share_text = "I am using the free Londata app to "
    
    func openOpenUrbanWesbite() {
        let urlStr = "https://openurban.org.uk/"
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url)
    }
    
//    func writeAReview() {
//        let urlStr = "https://apps.apple.com/app/londata/id1543000174?action=write-review"
//        guard let url = URL(string: urlStr) else { return }
//        UIApplication.shared.open(url)
//    }
    
    func share() {
        showShareSheet = true
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("👋 The LonData app is developed and maintained by OpenUrban CIC")
                            .font(.headline)
                        Text(text)
                        Button(action: openOpenUrbanWesbite) {
                            HStack {
                                Image(systemName: "arrow.up.right")
                                Text("More about OpenUrban CIC")
                            }
                        }
                    }
//                    VStack(alignment: .leading, spacing: 20) {
//                        Text("❤️ It would be amazing if you could leave us a rating on the App Store")
//                            .font(.headline)
//                        Button(action: writeAReview) {
//                            HStack {
//                                Image(systemName: "star.fill")
//                                Text("Rate this app")
//                            }.padding(.vertical,8)
//                            .padding(.horizontal, 20)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.blue, lineWidth: 2)
//                            )
//                        }
//                    }
//                    VStack(alignment: .leading, spacing: 20) {
//                        Text("😎 Share Toilets4London with someone else")
//                            .font(.headline)
//                        Button(action: share) {
//                            HStack {
//                                Image(systemName: "square.and.arrow.up")
//                                Text("Spread the word")
//                            }.padding(.vertical,8)
//                            .padding(.horizontal, 20)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.blue, lineWidth: 2)
//                            )
//                        }
//                    }
//                    .sheet(isPresented: $showShareSheet) {
//                        ShareSheet(activityItems: [share_text]).edgesIgnoringSafeArea(.bottom)
//                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text("📊 Data sources")
                            .font(.headline)
                        Text(air_source)
                        Text(covid_source)
                    }
                }.padding(15)
            }.navigationBarTitle("About LonData", displayMode: .inline)
        }
    }
}
struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
