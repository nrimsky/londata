//
//  CovidAPI.swift
//  londata
//
//  Created by Nina Rimsky on 26/02/2021.
//

import Foundation
import Combine

struct CovidAPI {
    private let agent = Agent()
    private let base = "https://api.coronavirus.data.gov.uk/v1/data?filters=areaType=ltla;"
    
    private func buildUrl(for borough: Borough) -> URL {
        let yesterdaysDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateString = dateFormatter.string(from: yesterdaysDate!)
        let nameEncoded = borough.name.replacingOccurrences(of:" ", with: "%20")
        let urlStr = base+"areaName=\(nameEncoded);date=\(dateString)&structure=%7B%22newCases%22:%22newCasesByPublishDate%22%7D&format=json&page=1"
        print(urlStr)
        return URL(string: urlStr)!
    }
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

}

protocol CovidDatasource {
    func cases(borough: Borough) -> AnyPublisher<CovidAPIResponse, Error>
}

extension CovidAPI: CovidDatasource {
    
    func cases(borough: Borough) -> AnyPublisher<CovidAPIResponse, Error> {
        let request = URLRequest(url: buildUrl(for: borough))
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

struct CovidAPIResponse: Codable {
    let data: [CovidAPIData?]?
}

struct CovidAPIData: Codable {
    let newCases: Int?
}

struct BoroughCovidCases {
    let newCases: Int
    let borough: Borough
}
