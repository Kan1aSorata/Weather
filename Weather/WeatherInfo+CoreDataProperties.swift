//
//  WeatherInfo+CoreDataProperties.swift
//  
//
//  Created by 贺峰煜 on 2020/11/25.
//
//

import Foundation
import CoreData


extension WeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfo> {
        return NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
    }

    @NSManaged public var temp: String?

}
