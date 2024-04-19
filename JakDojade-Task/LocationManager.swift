//
//  LocationManager.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import CoreLocation
import Foundation

protocol LocationManaging {
    func checkIfLocationServiceIsEnabled()
    var locationManager: CLLocationManager? { get }
}

final class LocationManager: NSObject, CLLocationManagerDelegate, LocationManaging {
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() {
        DispatchQueue.global().async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                self?.locationManager = CLLocationManager()
                self?.locationManager?.delegate = self
                self?.checkLocationAuthorization()
            } else {
                print("error")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("go to settings")
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
