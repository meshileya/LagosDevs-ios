//
//  AppDelegate.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = DashboardController()
        return true
    }

}

