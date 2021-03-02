//
//  LondataMapVM.swift
//  londata
//
//  Created by Nina Rimsky on 02/03/2021.
//

import Foundation
import Combine
import MapKit

class LondataMapVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let pollutionApi: PollutionDatasource
    private let covidApi: CovidDatasource
    private let crimeApi: CrimeDatasource
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Map centre
    
    @Published var mapCentre = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
    
    
    // MARK: - Data
    
    @Published var crimes = [StreetCrime]()
    @Published var pollutionData = [PollutionDatapoint]()
    @Published var covidCases = [Borough: Int]()
    
    // MARK: - List of boroughs
    
    private let boroughs: [Borough]
    
    // MARK: - Current location
    
    private let locationManager = CLLocationManager()
    private var initialisedAtMyLocation = false
    private var lastKnownLocation: CLLocationCoordinate2D?
    var authStatus: CLAuthorizationStatus = .notDetermined
    
    // MARK: Initialiser
    
    init(pollutionApi: PollutionDatasource = PollutionAPI(),
         covidApi: CovidDatasource = CovidAPI(),
         crimeApi: CrimeDatasource = CrimeAPI()) {
        self.pollutionApi = pollutionApi
        self.covidApi = covidApi
        self.crimeApi = crimeApi
        self.boroughs = PlaceNames.BOROUGHS.map{Borough(name: $0.key, latitude: $0.value.0, longitude: $0.value.1)}
        super.init()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = true
        requestAccessToLocation()
    }
    
    // MARK: - Api calls
    
    func getCrimes(for location: CLLocationCoordinate2D) {
        let cancellable = crimeApi.crimes(location: location)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Error \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] crimes in
                self?.crimes = crimes
            })
        cancellables.insert(cancellable)
    }
    
    private func getCovidCases(for borough: Borough) {
        let cancellable = covidApi.cases(borough: borough)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Error getting covid data for \(borough.name) : \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] apiResponse in
                print(apiResponse)
                if let cases = apiResponse.data?.first??.newCases {
                    self?.covidCases[borough] = cases
                }
            })
        cancellables.insert(cancellable)
    }
    
    func getAllCovidCases() {
        for borough in boroughs {
            getCovidCases(for: borough)
        }
    }
    
    func getPollutionData() {
        let cancellable = pollutionApi.pollutionDataLondon()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Error getting pollution data \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] apiResponse in
                print(apiResponse)
                self?.pollutionData = apiResponse.getPollutionDatapoints()
            })
        cancellables.insert(cancellable)
    }
    
    
    // MARK: - My location
    
    func requestAccessToLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
        
    func goToMyLocation() {
        if let userLocation = lastKnownLocation {
            mapCentre = userLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = locations.first?.coordinate {
            lastKnownLocation = coord
            if !initialisedAtMyLocation {
                goToMyLocation()
                initialisedAtMyLocation = true
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus){
        authStatus = status
    }
    
    
}
