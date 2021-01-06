//
//  AppDelegate.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/1.
//

import UIKit
import CoreLocation
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var locationManager = CLLocationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = UITabBarController()
        let cityViewController = CityViewController()
        let weatherViewController = WeatherViewController()
        let navigationController = UINavigationController(rootViewController: cityViewController)
//        let locationManager = CLLocationManager()
        locationService()
        cityViewController.loadViewIfNeeded()
        weatherViewController.loadViewIfNeeded()
        
        tabBarController.viewControllers = [navigationController, weatherViewController]
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = tabBarController
        return true
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "WeatherInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: -自己写的
    
    lazy var applicationDocumentsDirectory: URL = {
           // The directory the application uses to store the Core Data store file. This code uses a directory named "me.appkitchen.cd" in the application's documents Application Support directory.
           let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return urls[urls.count-1]
       }()
       lazy var managedObjectModel: NSManagedObjectModel = {
           // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
           let modelURL = Bundle.main.url(forResource: "WeatherInfo", withExtension: "momd")!
           return NSManagedObjectModel(contentsOf: modelURL)!
       }()
       lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
           // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
           // Create the coordinator and store
           let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
           let url = self.applicationDocumentsDirectory.appendingPathComponent("WeatherInfo.sqlite")
           var failureReason = "There was an error creating or loading the application's saved data."
           do {
               try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
           } catch {
               // Report any error we got.
               var dict = [String: AnyObject]()
               dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
               dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
               
               dict[NSUnderlyingErrorKey] = error as NSError
               let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
               // Replace this with code to handle the error appropriately.
               // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
               abort()
           }
           
           return coordinator
       }()
       lazy var managedObjectContext: NSManagedObjectContext = {
           // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
           let coordinator = self.persistentStoreCoordinator
           var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
           managedObjectContext.persistentStoreCoordinator = coordinator
           return managedObjectContext
       }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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


