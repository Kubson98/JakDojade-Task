//
//  AppDelegate.swift
//  JakDojade-Task
//
//  Created by Jakub Sędal on 18/04/2024.
//


import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        presentRootView()
        return true
    }
    
    private func presentRootView() {
        let dependencies = Dependencies()
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        MainCoordinator(
            navigationController: navigationController,
            dependencies: dependencies,
            viewFactory: .init(dependencies: dependencies)
        ).start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
