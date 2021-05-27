//
//  AppDelegate.swift
//  Adichallenge
//
//  Created by Alex Cuello on 27/05/2021.
//

import UIKit

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let factory = DiscoverGymsFactory()
//
//        let viewController = factory.makeDiscoverGymsViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DiscoverProductsViewController() //navigationController
        window?.makeKeyAndVisible()
         return true
     }
}
