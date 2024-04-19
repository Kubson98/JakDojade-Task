//
//  Dependencies.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import Foundation
import Services

struct Dependencies {
    let manager: ServiceManaging = ServiceManager()
    let locationManager: LocationManaging = LocationManager()
}
