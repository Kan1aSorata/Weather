//
//  cityCoreDataModel.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/26.
//

import Foundation
import UIKit
import CoreData

class cityCoreDataModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private func saveData() {
        do {
            try context.save()
        } catch {
            print("保存出错")
        }
    }
    
    func addNewCityData(_ data: String) {
        let cityInfo = NSEntityDescription.insertNewObject(forEntityName: "CityInfo", into: context) as! CityInfo
        cityInfo.city = data
        saveData()
    }
    
    func getCityData() -> [String]{
        var data = [String]()
        do {
            let request = NSFetchRequest<CityInfo>(entityName: "CityInfo")
            let getData = try context.fetch(request)
            data = getData.map {($0.city!)}
        } catch {
            print("查询失败")
        }
        return data
    }
    
    func deleteData() {
        do {
            let request = NSFetchRequest<CityInfo>(entityName: "CityInfo")
            let getData = try context.fetch(request) as [NSManagedObject]
            for data in getData as! [CityInfo] {
                context.delete(data)
            }
        } catch {
            print("查询失败")
        }
    }
}
