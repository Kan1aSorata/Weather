//
//  CityInfo+CoreDataProperties.swift
//  
//
//  Created by 贺峰煜 on 2020/12/3.
//
//

import Foundation
import CoreData


extension CityInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityInfo> {
        return NSFetchRequest<CityInfo>(entityName: "CityInfo")
    }

    @NSManaged public var city: String?

}
