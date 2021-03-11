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
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Map centre
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.5))
    
    
    // MARK: - Data
    
    @Published var pollutionData = [PollutionDatapoint]()
    @Published var mapMarkers = [MapMarker]()
    
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false
    
    var mapMarkerPublisher: AnyPublisher<[MapMarker],Never> {
        $pollutionData.map { pollutionData in
            return pollutionData.map{ MapMarker(pollutionData: $0)}
        }.eraseToAnyPublisher()
    }
    
    // MARK: - Current location
    
    private let locationManager = CLLocationManager()
    private var initialisedAtMyLocation = false
    private var lastKnownLocation: CLLocationCoordinate2D?
    var authStatus: CLAuthorizationStatus = .notDetermined
    
    // MARK: Initialiser
    
    init(pollutionApi: PollutionDatasource = PollutionAPI()) {
        self.pollutionApi = pollutionApi
        super.init()
        mapMarkerPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.mapMarkers, on: self)
            .store(in: &cancellables)
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = true
        requestAccessToLocation()
    }
    
    // MARK: - Api calls
    
    func getPollutionData() {
        hasError = false
        self.isLoading = true
        let cancellable = pollutionApi.pollutionDataLondon()
            .sink(receiveCompletion: { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    print("Error getting pollution data \(error)")
                    if (!(self?.hasError ?? false)) {
                        self?.hasError = true
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] apiResponse in
                self?.isLoading = false
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
            region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
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
