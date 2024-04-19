//
//  StationAdapter.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import Foundation
import Services

protocol StationAdapting {
    func adapt(stations: [Station], statuses: [StationStatus]) -> [BikeStation]
}

class StationAdapter: StationAdapting {
    let distanceCalculator: DistanceCalculating
    
    init(distanceCalculator: DistanceCalculating) {
        self.distanceCalculator = distanceCalculator
    }
    
    func adapt(stations: [Station], statuses: [StationStatus]) -> [BikeStation] {
        var allStations: [BikeStation] = []
        stations.forEach { station in
            guard let currentStatus = statuses.filter({ $0.stationId == station.stationId }).first 
            else { return }
            allStations.append(
                .init(
                    stationId: station.stationId,
                    name: "\(station.name) \(station.address)",
                    numBikesAvailable: currentStatus.numBikesAvailable,
                    numDocksAvailable: currentStatus.numDocksAvailable,
                    lat: station.lat,
                    lon: station.lon,
                    distance: distanceCalculator.fetchDistance(
                        from: .init(
                            latitude: station.lat,
                            longitude: station.lon
                        )
                    ),
                    address: station.crossStreet
                )
            )
        }
        return allStations
    }
}
