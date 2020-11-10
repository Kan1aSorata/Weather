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
        
        let tabBarController = UITabBarController()
        let cityViewController = CityViewController()
        let weatherViewController = WeatherViewController()
        
        weatherViewController.loadViewIfNeeded()
        cityViewController.loadViewIfNeeded()
        
        tabBarController.viewControllers = [cityViewController, weatherViewController]
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        return true
    }
}

