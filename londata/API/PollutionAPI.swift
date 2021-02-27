//
//  PollutionAPI.swift
//  londata
//
//  Created by Nina Rimsky on 26/02/2021.
//

import Foundation
import Combine

enum PollutionAPI {
    static let url = URL(string: "http://api.erg.ic.ac.uk/AirQuality/Hourly/MonitoringIndex/GroupName=London/Json")!
    static let agent = Agent()
}

extension PollutionAPI {
    
    static func pollutionDataLondon() -> AnyPublisher<PollutionAPIResponse, Error> {
        let request = URLRequest(url: url)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}


struct PollutionAPIResponse: Codable {
    let HourlyAirQualityIndex: HourlyAirQualityIndexData
}

struct HourlyAirQualityIndexData: Codable {
    let LocalAuthority: [LocalAuthorityData]
}

struct LocalAuthorityData {
    let code: String?
    let name: String?
    let latStr: StringBacked<Double>
    let lonStr: StringBacked<Double>
    
    var latitude: Double {
        get { return latStr.value }
    }
    var longitude: Double {
        get { return lonStr.value }
    }
    
    let siteData: [PollutionSiteData]
    
}

extension LocalAuthorityData: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "@LocalAuthorityCode"
        case name = "@LocalAuthorityName"
        case latStr = "@LaCentreLatitude"
        case lonStr = "@LaCentreLongitude"
        case siteData = "Site"
    }
}

struct PollutionSiteData: Codable {
    let Species: [PollutionSpecies]
}

struct PollutionSpecies {
    let code: String
    let description: String
    let qualityIndex: String
    let qualityBand: String
}

extension PollutionSpecies: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "@LocalAuthorityCode"
        case description = "@SpeciesDescription"
        case qualityIndex = "@AirQualityIndex"
        case qualityBand = "@AirQualityBand"
    }
}
