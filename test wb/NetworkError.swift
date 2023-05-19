//
//  NetworkError.swift
//  test wb
//
//  Created by Diego Abramoff on 18.05.23.
//

import Foundation

enum NetworkError: Error, CustomDebugStringConvertible {
    
    case server(description: String)
    case parse(description: String)
    case unknown
    
    var debugDescription: String {
        switch self {
        case .server(let description): return "ошибка сервера: \(description)"
        case let .parse(description): return "ошибка парсинга: \(description)"
        case .unknown: return "неизвестная ошибка"
        }
    }
}
