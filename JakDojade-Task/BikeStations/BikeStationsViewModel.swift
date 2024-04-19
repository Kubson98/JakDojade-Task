//
//  BikeStationsViewModel.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import CoreLocation
import Foundation

class BikeStationsViewModel: ObservableObject {
    @Published private(set) var allStations: [BikeStation] = []
    private let stationsFetcher: StationsFetcher
    private let statusFetcher: StatusFetcher
    private let stationAdapter: StationAdapting
    private let coordinator: Coordinating
    
    init(
        stationsFetcher: StationsFetcher,
        statusFetcher: StatusFetcher,
        stationAdapter: StationAdapting,
        coordinator: Coordinating
    ) {
        self.stationsFetcher = stationsFetcher
        self.statusFetcher = statusFetcher
        self.stationAdapter = stationAdapter
        self.coordinator = coordinator
        fetchData()
    }
    
    func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        stationsFetcher.fetchStations {
            group.leave()
        }
        
        group.enter()
        statusFetcher.fetchStatuses {
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.allStations = self.stationAdapter.adapt(
                stations: stationsFetcher.stations,
                statuses: statusFetcher.statuses
            )
        }
    }
    
    func goToDetails(for station: BikeStation) {
        coordinator.coordinate(to: .details(station))
    }
}
