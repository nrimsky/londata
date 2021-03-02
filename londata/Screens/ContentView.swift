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
        VStack {
            CovidMap(covidCases: $vm.covidCases)
            PollutionMap(pollutionData: $vm.pollutionData)
        }.onAppear {
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
