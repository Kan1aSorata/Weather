//
//  AppDelegate.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/1.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = UITabBarController()
        let cityViewController = CityViewController()
        let weatherViewController = WeatherViewController()
        
        cityViewController.loadViewIfNeeded()
        weatherViewController.loadViewIfNeeded()
        
        tabBarController.viewControllers = [cityViewController, weatherViewController]
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = tabBarController
        return true
    }
}

