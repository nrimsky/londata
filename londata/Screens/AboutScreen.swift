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
    
    let about = """
    This app displays real time London air quality sensor data on a simple map. Points are colour coded based on the maximum quality index of a pollutant at that point.
    """
    
    let atrisk = """
    1–3: Enjoy your usual outdoor activities.
    4–6: Adults and children with lung problems, and adults with heart problems, who experience symptoms, should consider reducing strenuous physical activity, particularly outdoors.
    7–9: Adults and children with lung problems, and adults with heart problems, should reduce strenuous physical exertion, particularly outdoors, and particularly if they experience symptoms. People with asthma may find they need to use their reliever inhaler more often. Older people should also reduce physical exertion.
    10: Adults and children with lung problems, adults with heart problems, and older people, should avoid strenuous physical activity. People with asthma may find they need to use their reliever inhaler more often.
    """
    
    let general = """
    1-6: Enjoy your usual outdoor activities.
    7–9: Anyone experiencing discomfort such as sore eyes, cough or sore throat should consider reducing activity, particularly outdoors.
    10: Reduce physical exertion, particularly outdoors, especially if you experience symptoms such as cough or sore throat.
    """

    let air_source = """
    Air quality data is obtained from the Environmental Research Group of Kings College
    London (http://www.erg.kcl.ac.uk), using data from the London Air Quality Network
    (http://www.londonair.org.uk). This data is licensed under the terms of the Open
    Government Licence.
    """

    
    func close() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(about)
                    HStack(alignment: .top, spacing: 10 ) {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Health messages for At-risk individuals").bold()
                            Text(atrisk)
                            Text("Health messages for General population").bold()
                            Text(general)
                        }
                        Spacer()
                        Gradient()
                    }
                    Text("📊 Data sources")
                        .font(.headline)
                    Text(air_source)
                }.padding(15)
            }
            .navigationBarTitle("About", displayMode: .inline)
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
