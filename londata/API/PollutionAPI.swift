//
//  PollutionAPI.swift
//  londata
//
//  Created by Nina Rimsky on 26/02/2021.
//

import Foundation
import Combine

struct PollutionAPI {
    private let url = URL(string: "https://api.erg.ic.ac.uk/AirQuality/Hourly/MonitoringIndex/GroupName=London/Json")!
    private let agent = Agent()
}

protocol PollutionDatasource {
    func pollutionDataLondon() -> AnyPublisher<PollutionAPIResponse, Error>
}

extension PollutionAPI: PollutionDatasource {
    
    func pollutionDataLondon() -> AnyPublisher<PollutionAPIResponse, Error> {
        let request = URLRequest(url: url)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}


struct PollutionAPIResponse {
    let hourlyAirQualityIndex: HourlyAirQualityIndexData
    
    func getPollutionDatapoints() -> [PollutionDatapoint] {
        return hourlyAirQualityIndex.localAuthority.compactMap{$0.siteData?.data}.flatMap{$0}.compactMap{
            let dataPoints = $0.getSpeciesDatapoints()
            if let speciesDataPoints = dataPoints, speciesDataPoints.count > 0 {
                return PollutionDatapoint(speciesData: speciesDataPoints, placeName: $0.siteName, latitude: $0.latitude, longitude: $0.longitude)
            } else {
                return nil
            }
        }
    }
}

extension PollutionAPIResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case hourlyAirQualityIndex = "HourlyAirQualityIndex"
    }
}

struct HourlyAirQualityIndexData {
    let localAuthority: [LocalAuthorityData]
}

extension HourlyAirQualityIndexData: Codable {
    enum CodingKeys: String, CodingKey {
        case localAuthority = "LocalAuthority"
    }
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
    
    let siteData: Site?
    
}


struct Site: Codable {
    
    let data: [PollutionSiteData]

    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        if let dataList =  try? container.decode(Array<PollutionSiteData>.self) {
            data = dataList
        } else if let dataSingle = try? container.decode(PollutionSiteData.self) {
            var dataList = [PollutionSiteData]()
            dataList.append(dataSingle)
            data = dataList
        } else {
            data = [PollutionSiteData]()
        }
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }
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

struct PollutionSiteData {
    let species: Species
    let latStr: StringBacked<Double>
    let lonStr: StringBacked<Double>
    let siteName: String
    
    var latitude: Double {
        get { return latStr.value }
    }
    var longitude: Double {
        get { return lonStr.value }
    }
    
    func getSpeciesDatapoints() -> [SpeciesDatapoint]? {
        return species.data.compactMap {
            ($0.qualityIndex != 0) ? SpeciesDatapoint(speciesName: $0.description, qualityIndex: $0.qualityIndex) : nil
        }
    }
}

extension PollutionSiteData: Codable {
    enum CodingKeys: String, CodingKey {
        case species = "Species"
        case latStr = "@Latitude"
        case lonStr = "@Longitude"
        case siteName = "@SiteName"
    }
}

struct Species: Codable {
    
    let data: [PollutionSpecies]

    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        do {
            data = try container.decode(Array<PollutionSpecies>.self)
        } catch {
            let item = try container.decode(PollutionSpecies.self)
            data = [item]
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }
}

struct PollutionSpecies {
    let code: String?
    let description: String
    let qualityIndexStr: StringBacked<Int>
    var qualityIndex: Int {
        get { return qualityIndexStr.value }
    }
    let qualityBand: String?
}

extension PollutionSpecies: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "@LocalAuthorityCode"
        case description = "@SpeciesDescription"
        case qualityIndexStr = "@AirQualityIndex"
        case qualityBand = "@AirQualityBand"
    }
}
