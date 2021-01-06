//
//  ProvinceInfo+CoreDataProperties.swift
//  
//
//  Created by 贺峰煜 on 2020/12/3.
//
//

import Foundation
import CoreData


extension ProvinceInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProvinceInfo> {
        return NSFetchRequest<ProvinceInfo>(entityName: "ProvinceInfo")
    }

    @NSManaged public var province: String?

}
