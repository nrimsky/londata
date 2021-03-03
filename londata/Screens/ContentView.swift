//
//  ContentView.swift
//  londata
//
//  Created by Nina Rimsky on 26/02/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var vm = LondataMapVM()
    @State var showInfoSheet: Bool = false
    
    func fetchData() {
        vm.getAllCovidCases()
        vm.getPollutionData()
    }
    
    var body: some View {
        NavigationView {
            DataMap(region: $vm.region, mapMarkers: $vm.mapMarkers)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                leading:
                    Button(action: { showInfoSheet = true }) {
                        HStack {
                            Text("About")
                            Image(systemName: "info.circle")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    },
                trailing:
                    VStack {
                        Button(action: fetchData) {
                            HStack {
                                Text("Refresh")
                                Image(systemName: "goforward")
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                            }
                        }
                        Button(action: vm.goToMyLocation) {
                            HStack {
                                Text("My location")
                                Image(systemName: "location.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                                
                            }
                        }
                        
                    }
                )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
