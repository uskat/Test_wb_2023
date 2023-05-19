//
//  NetworkManager.swift
//  test wb
//
//  Created by Diego Abramoff on 18.05.23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func urlComponents() -> URLComponents {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "vmeste.wildberries.ru"
        urlComponents.path = "/api/avia-service/twirp/aviaapijsonrpcv1.WebAviaService/GetCheap"
        
        return urlComponents
    }

    func fetchData(fromAddress address: URLComponents, completion: @escaping (Result<[Flight], NetworkError>) -> Void) {
        guard let url = address.url,
              let body = "{\"startLocationCode\": \"LED\"}".data(using: .utf8)
        else {
            completion(.failure(.unknown))
//            print("failure unknown with url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = body

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.server(description: error.localizedDescription)))
//                print("failure server = \(error)")
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
//                print("failure unknown with data")
                return
            }

            DispatchQueue.main.async {
                do {
                    let flights = try JSONDecoder().decode(Flights.self, from: data)
                    completion(.success(flights.flights))
                } catch {
                    completion(.failure(.parse(description: error.localizedDescription)))
//                    print("failure parse")
                }
            }
        }.resume()
    }
}
