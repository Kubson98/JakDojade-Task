//
//  StationFetcher.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import Foundation
import Services

final class StationsFetcher {
    @Published private(set) var stations: [Station] = []
    private let service: ServiceManaging
    
    init(service: ServiceManaging) {
        self.service = service
    }
    
    func fetchStations(completion: @escaping () -> Void) {
        service.fetchData(for: .stations) { [weak self] (result: Result<StationResponse, APIError>) in
            switch result {
            case .success(let response):
                let stations = response.data.stations
                DispatchQueue.main.async {
                    self?.stations = stations
                }
                completion()
            case .failure:
                break
            }
        }
    }
}
