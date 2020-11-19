//
//  AppDelegate.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/1.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var locationManager = CLLocationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = UITabBarController()
        let cityViewController = CityViewController()
        let weatherViewController = WeatherViewController()
//        let locationManager = CLLocationManager()
        locationService()
        cityViewController.loadViewIfNeeded()
        weatherViewController.loadViewIfNeeded()
        
        tabBarController.viewControllers = [cityViewController, weatherViewController]
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = tabBarController
        return true
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationService() {
            //设置定位服务管理器代理位置
            locationManager.delegate = self
            //设置定位精度
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.distanceFilter = 100
            locationManager.requestAlwaysAuthorization()
            if(CLLocationManager.locationServicesEnabled()) {
                locationManager.startUpdatingLocation()
                print("start locating")
            }
        }
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let currentLocation = locations.last!
                let weatherViewController = WeatherViewController()
                weatherViewController.longtitude = String(currentLocation.coordinate.longitude)
                print("1 " + String(currentLocation.coordinate.longitude))
                weatherViewController.latitude = String(currentLocation.coordinate.latitude)
                print("2 " + String(currentLocation.coordinate.latitude))
        }
}

