//
//  StatusFetcher.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import Foundation
import Services

final class StatusFetcher {
    @Published private(set) var statuses: [StationStatus] = []
    private let service: ServiceManaging
    
    init(service: ServiceManaging) {
        self.service = service
    }
    
    func fetchStatuses(completion: @escaping () -> Void) {
        service.fetchData(for: .status) { [weak self] (result: Result<StatusResponse, APIError>) in
            switch result {
            case .success(let response):
                let stations = response.data.stations
                DispatchQueue.main.async {
                    self?.statuses = stations
                }
                completion()
            case .failure:
                print("error")
            }
        }
    }
}
