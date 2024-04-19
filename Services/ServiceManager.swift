//
//  ServiceManager.swift
//  Services
//
//  Created by Jakub Sędal on 19/04/2024.
//

import Foundation

public enum FetchingType {
    case stations
    case status
    
    var url: URL? {
        switch self {
        case .status:
            return URL(string: "https://gbfs.urbansharing.com/rowermevo.pl/station_status.json")
        case .stations:
            return URL(string: "https://gbfs.urbansharing.com/rowermevo.pl/station_information.json")
        }
    }
}

public protocol ServiceManaging {
    func fetchData<T: Decodable>(for fetchingType: FetchingType, completion: @escaping (Result<T, APIError>) -> Void)
}

public class ServiceManager: ServiceManaging {
    public func fetchData<T>(for fetchingType: FetchingType, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        guard let url = fetchingType.url else {
            completion(.failure(.networkError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    public init() {}
}
