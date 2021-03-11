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
        vm.getPollutionData()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                DataMap(region: $vm.region, mapMarkers: $vm.mapMarkers)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(
                    leading:
                        HStack(spacing: 20) {
                            Button(action: fetchData) {
                                Image(systemName: "arrow.clockwise")
                                    .accessibilityLabel( Text("Reload"))
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                            }
                            Button(action: { showInfoSheet = true }) {
                                Image(systemName: "info.circle")
                                    .accessibilityLabel( Text("About this app"))
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                            }
                        },
                    trailing:
                        Button(action: vm.goToMyLocation) {
                            HStack(spacing: 2) {
                                Image(systemName: "location.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                                Text("Go to my location")
                                
                            }
                        }
                    )
                if (vm.hasError) {
                    ErrorView(onClick: { [vm] in
                        vm.getPollutionData()
                    })
                }
                if (vm.isLoading) {
                    LoadingIndicator()
                }
            }.sheet(isPresented: $showInfoSheet) {
                AboutScreen()
                    .edgesIgnoringSafeArea(.all)
            }
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
