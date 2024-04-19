//
//  DistanceCalculator.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import CoreLocation
import Foundation

protocol DistanceCalculating {
    func fetchDistance(from stationLocation: CLLocation) -> String
}

final class DistanceCalculator: NSObject, DistanceCalculating {
    let locationManager: LocationManaging
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager
        locationManager.checkIfLocationServiceIsEnabled()
    }
        
    func fetchDistance(from stationLocation: CLLocation) -> String {
        guard let currentLocation = locationManager.locationManager?.location else {
            return "No Distance"
        }
        let result = Int(currentLocation.distance(from: stationLocation))
        return setResultAndUnit(for: result)
    }
    
    private func setResultAndUnit(for result: Int) -> String {
        var unit = "m"
        var formattedResult = result
        if result > 1000 {
            unit = "km"
            formattedResult /= 1000
        }
        return "\(formattedResult) \(unit)"
    }

}
