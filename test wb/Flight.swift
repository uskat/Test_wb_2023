//
//  Flight.swift
//  test wb
//
//  Created by Diego Abramoff on 17.05.23.
//

import Foundation

struct Flights: Decodable {
    let flights: [Flight]
    
    enum CodingKeys: String, CodingKey {
        case flights
    }
}

struct Flight: Decodable {
    let startDate: String
    let endDate: String
    let startCity: String
    let endCity: String
    let price: Int
    
    enum FlightCodingKeys: String, CodingKey {
        case startCity, endCity, startDate, endDate, price
    }
    
    init(from decoder: Decoder) throws {
        let flightsContainer = try decoder.container(keyedBy: FlightCodingKeys.self)
        startCity = try flightsContainer.decode(String.self, forKey: .startCity)
        endCity = try flightsContainer.decode(String.self, forKey: .endCity)
        startDate = try flightsContainer.decode(String.self, forKey: .startDate)
        endDate = try flightsContainer.decode(String.self, forKey: .endDate)
        price = try flightsContainer.decode(Int.self, forKey: .price)
    }
}
