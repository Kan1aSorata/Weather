//
//  provinceCoreDataModel.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/26.
//

import Foundation
import UIKit
import CoreData

class provinceCoreDataModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private func saveData() {
        do {
            try context.save()
        } catch {
            print("保存出错")
        }
    }

    
    func addNewProvinceData(_ data: String) {
        let provinceInfo = NSEntityDescription.insertNewObject(forEntityName: "ProvinceInfo", into: context) as! ProvinceInfo
        provinceInfo.province = data
        saveData()
    }
    
    func getProvinceData() -> [String]{
        var data = [String]()
        do {
            let request = NSFetchRequest<ProvinceInfo>(entityName: "ProvinceInfo")
            let getData = try context.fetch(request)
            data = getData.map {($0.province!)}
        } catch {
            print("查询失败")
        }
        return data
    }
    
    func deleteData() {
        do {
            let request = NSFetchRequest<ProvinceInfo>(entityName: "ProvinceInfo")
            let getData = try context.fetch(request) as [NSManagedObject]
            for data in getData as! [ProvinceInfo] {
                context.delete(data)
            }
        } catch {
            print("查询失败")
        }
    }
}
