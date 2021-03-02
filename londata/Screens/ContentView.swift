//
//  ContentView.swift
//  londata
//
//  Created by Nina Rimsky on 26/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = LondataMapVM()
    
    var body: some View {
        LondataMap(pollutionData: $vm.pollutionData, covidCases: $vm.covidCases).onAppear {
            vm.getAllCovidCases()
            vm.getPollutionData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
