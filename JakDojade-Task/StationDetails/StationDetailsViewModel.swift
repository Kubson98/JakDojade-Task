//
//  StationDetailsViewModel.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 19/04/2024.
//

import CoreLocation
import Foundation

class StationDetailsViewModel: ObservableObject {
    @Published private(set) var userLocation: CLLocationCoordinate2D
    @Published private(set) var station: BikeStation
    private let coordinator: Coordinating
    
    init(
        userLocation: CLLocationCoordinate2D,
        station: BikeStation,
        coordinator: Coordinating
    ) {
        self.userLocation = userLocation
        self.station = station
        self.coordinator = coordinator
    }
    
    func popToHomeView() {
        coordinator.pop()
    }
}
