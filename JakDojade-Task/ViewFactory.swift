//
//  ViewFactory.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import SwiftUI
import CoreLocation

final class ViewFactory {
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @ViewBuilder func buildBikeStationsView(coordinator: Coordinating) -> some View {
        let stationsFetcher = StationsFetcher(service: dependencies.manager)
        let statusFetcher = StatusFetcher(service: dependencies.manager)
        let distanceCalculator = DistanceCalculator(locationManager: dependencies.locationManager)
        let stationAdapter = StationAdapter(distanceCalculator: distanceCalculator)

        let viewModel = BikeStationsViewModel(
            stationsFetcher: stationsFetcher,
            statusFetcher: statusFetcher,
            stationAdapter: stationAdapter,
            coordinator: coordinator
        )
        BikeStationsView(viewModel: viewModel)
    }
    
    @ViewBuilder func buildDetailsView(
        for station: BikeStation,
        userLocation: CLLocationCoordinate2D,
        coordinator: Coordinating
    ) -> some View {
        let viewModel = StationDetailsViewModel(
            userLocation: userLocation,
            station: station,
            coordinator: coordinator
        )
        StationDetailsView(viewModel: viewModel)
    }
}
