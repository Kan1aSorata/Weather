//
//  WeatherViewController.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/3.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    var city: String? {
        didSet {
            self.cityUrl = city
            self.testLabel.text = city
        }
    }
    private var cityUrl: String?
    private var testLabel = UILabel()
    private var testLabel1 = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "天气"
        tabBarItem.image = UIImage(systemName: "sun.haze")
        
        testLabel1.frame = CGRect(x: 10, y: 220, width: 200, height: 200)
        view.addSubview(testLabel1)
        
        testLabel.frame = CGRect(x: 10, y: 10, width: 200, height: 200)
        view.addSubview(testLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getLocation() { cityId -> Void in
            self.getWeather(cityId: cityId) { temp -> Void in
                self.testLabel1.text = temp
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.testLabel.text = ""
            self.testLabel1.text = ""
    }
    
    func getLocation(callBack: @escaping (String) -> Void) {
        let parameters = ["key": "2277d865653b45f8af818efa55550d98", "location": cityUrl]
        AF.request("https://geoapi.qweather.com/v2/city/lookup", method: .get, parameters: parameters).validate().responseJSON { responds in
            switch responds.result {
            case .success(let value):
                let json = JSON(value)
                //回调
                callBack(json["location"].arrayValue.first!["id"].stringValue)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWeather(cityId: String, callBack: @escaping (String) -> Void) {
        let paramenters = ["key": "2277d865653b45f8af818efa55550d98", "location": cityId]
        AF.request("https://devapi.qweather.com/v7/weather/now", method: .get, parameters: paramenters).validate().responseJSON {responds in
            switch responds.result {
            case .success(let value):
                let json = JSON(value)
                print(json["now"]["temp"].string!)
                callBack(json["now"]["temp"].string!)
            case .failure(let error):
                print(error)
            }
        }
    }
}

