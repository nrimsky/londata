//
//  CovidAPI.swift
//  londata
//
//  Created by Nina Rimsky on 26/02/2021.
//

import Foundation
import Combine

enum CovidAPI {
    static let agent = Agent()
    static let base = URL(string: "https://api.coronavirus.data.gov.uk/v1/data?filters=areaType=ltla;")!
    
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}

struct CovidAPIResponse: Codable {
    let data: CovidAPIData?
}

struct CovidAPIData: Codable {
    let newCases: Int?
}

extension CovidAPI {
    
    static func cases(areaName: String) -> AnyPublisher<CovidAPIResponse, Error> {
        let todaysDate = Date()
        let dateString = dateFormatter.string(from: todaysDate)
        let request = URLRequest(url:base
            .appendingPathComponent(
                "areaName=\(areaName);date=\(dateString)&structure={%22newCases%22:%22newCasesByPublishDate%22}&format=json&page=1"
            )
        )
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
