//
//  AppDelegate.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: SeriesConfigurator().resolveViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
