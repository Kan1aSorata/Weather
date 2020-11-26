//
//  CoreDataModel.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/26.
//

import Foundation
import UIKit
import CoreData

class CoreDataModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private func saveData() {
        do {
            try context.save()
        } catch {
            print("保存出错")
        }
    }
    
    func addNewData(_ data: String) {
        let weatherInfo = NSEntityDescription.insertNewObject(forEntityName: "WeatherInfo", into: context) as! WeatherInfo
        weatherInfo.temp = data
        saveData()
    }
    
    func getData() -> [String]{
        var data = [String]()
        do {
            let request = NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
            let getData = try context.fetch(request)
            data = getData.map {($0.temp!)}
        } catch {
            print("查询失败")
        }
        return data
    }
    
    func deleteData() {
        do {
            let request = NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
            let getData = try context.fetch(request) as [NSManagedObject]
            for data in getData as! [WeatherInfo] {
                context.delete(data)
            }
        } catch {
            print("查询失败")
        }
    }
//    func saveData(data: String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let manageContext = appDelegate.managedObjectContext
//        let weatherInfoIn = NSEntityDescription.entity(forEntityName: "WeatherInfo", in: manageContext)
//        let dataIn = NSManagedObject.init(entity: weatherInfoIn!, insertInto: manageContext)
//        dataIn.setValue(data, forKey: "temp")
//        do {
//            try manageContext.save()
//            self.weatherInfo.setValue(dataIn, forKey: "temp")
//        } catch {
//            print("ERROR")
//        }
//    }
//
//    func deleteData(dataIndexPath: IndexPath) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let manageContext = appDelegate.managedObjectContext
//
//        manageContext.delete(self.weatherInfo)
//
//        do {
//            try manageContext.save()
//            self.weatherInfo.setValue(nil, forKey: "temp")
//        } catch  {
//            print("存储错误...")
//        }
//    }
}
