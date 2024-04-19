//
//  Coordinator.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//

import SwiftUI

enum Destination {
    case stations
    case details(BikeStation)
}

protocol Coordinating {
    var navigationController: UINavigationController { get }
    func start()
    func pop()
    func coordinate(to destination: Destination)
}

final class MainCoordinator: Coordinating {
    var navigationController: UINavigationController
    private let dependencies: Dependencies
    let viewFactory: ViewFactory
    
    init(
        navigationController: UINavigationController,
        dependencies: Dependencies,
        viewFactory: ViewFactory
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.viewFactory = viewFactory
    }
    
    func start() {
        coordinate(to: .stations)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func coordinate(to destination: Destination) {
        switch destination {
        case .stations:
            let vc = UIHostingController(rootView: viewFactory.buildBikeStationsView(coordinator: self))
            navigationController.pushViewController(vc, animated: true)
        case .details(let station):
            let vc = UIHostingController(
                rootView: viewFactory.buildDetailsView(
                    for: station,
                    userLocation: .init(
                        latitude: dependencies.locationManager.locationManager?.location?.coordinate.latitude ?? 0,
                        longitude: dependencies.locationManager.locationManager?.location?.coordinate.longitude ?? 0),
                    coordinator: self
                )
            )
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
