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
import SnapKit
import CoreData


class WeatherViewController: UIViewController {
    var city: String? = "等待请求"{
        didSet {
            self.cityUrl = city
            self.testLabel.text = city
        }
    }
    
    var longtitude: String? {
        didSet {
            self.defaultLongtitude = longtitude
        }
    }
    
    var latitude: String? {
        didSet {
            self.defaultLatitude = latitude
        }
    }
    private let model = CoreDataModel()
    private var cityUrl: String?
    private var defaultLongtitude: String?
    private var defaultLatitude: String?
    private var testLabel = UILabel()
    private var testLabel1 = UILabel()
    private var testLabel2 = UILabel()
    private var button = UIButton()
    private let view2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "天气"
        tabBarItem.image = UIImage(systemName: "sun.haze")
        
//        getDefaultLocation() { (idJSON, nameJSON) -> Void in
//            self.getDefaultWeather(idJSON) { temp -> Void in
//                self.testLabel1.text = temp
//            }
//            self.testLabel.text = nameJSON
//        }
        view2.backgroundColor = UIColor.init(red: 16/225, green: 78/225, blue: 139/225, alpha: 1)
        view2.layer.cornerRadius = 20
        view2.addSubview(testLabel1) //温度
        view2.addSubview(testLabel) //城市
        view2.addSubview(testLabel2) //feelsLike
        view.addSubview(view2)
        testLabel.font = UIFont.boldSystemFont(ofSize: 40)
        testLabel.textColor = .white
        testLabel.shadowColor = .black
        testLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
        testLabel.adjustsFontSizeToFitWidth = true
        testLabel1.font = UIFont.systemFont(ofSize: 80)
        testLabel2.font = UIFont.boldSystemFont(ofSize: 30)
        testLabel2.textColor = .white
        testLabel.snp.makeConstraints{(make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(10)
        }
        testLabel1.snp.makeConstraints{(make) in
            make.top.equalTo(testLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
        }
        testLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(testLabel.snp.bottom).offset(10)
            make.right.equalTo(10)
        }
        view2.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(testLabel1.snp.bottom).offset(10)
        }
        
        button.backgroundColor = .blue
        button.setTitle("Data check", for: .normal)
        button.addTarget(self, action: #selector(dataCheck), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints {(make) in
            make.top.equalTo(view2.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(10)
        }
    }
    
    @objc func dataCheck() {
        print(model.getData())
        print()
        print("输出成功")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        getLocation() {cityId -> Void in
//            self.getWeather(cityId: cityId) { temp -> Void in
//                self.testLabel1.text = temp
//            }
//        }
        getLocation() { [self] cityId -> Void in
            self.getWeather(cityId: cityId)
            self.testLabel1.text = model.getData()[0]
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.testLabel.text = ""
        self.testLabel1.text = ""
//        let a: WeatherInfo? = nil
//        UIView.animate(withDuration: 3) {
//
//        }
    }
    
    func getDefaultLocation(callBack: @escaping (String, String) -> Void){
        let location = (defaultLongtitude ?? "") + "," + (defaultLatitude ?? "")
        let parameters = ["key": "2277d865653b45f8af818efa55550d98", "location": location]
            AF.request("https://geoapi.qweather.com/v2/city/lookup", method: .get, parameters: parameters).validate().responseJSON { responds in
                switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    callBack((json["location"].arrayValue.first ?? [])["id"].stringValue, (json["location"].arrayValue.first ?? [])["name"].stringValue)
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    func getDefaultWeather(_ cityID: String, callBack: @escaping (String) -> Void){
            let paramenters = ["key": "2277d865653b45f8af818efa55550d98", "location": cityID]
            AF.request("https://devapi.qweather.com/v7/weather/now", method: .get, parameters: paramenters).validate().responseJSON {responds in
                switch responds.result {
                case .success(let value):
                    let json = JSON(value)
                    callBack(json["now"]["temp"].string ?? "")
                case .failure(let error):
                    print(error)
                }
            }
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

    func getWeather(cityId: String) {
        let paramenters = ["key": "2277d865653b45f8af818efa55550d98", "location": cityId]
        AF.request("https://devapi.qweather.com/v7/weather/now", method: .get, parameters: paramenters).validate().responseJSON {responds in
            switch responds.result {
            case .success(let value):
                let json = JSON(value)
//                callBack(json["now"]["temp"].string!)//TODO：返回多个数据
                self.model.addNewData(json["now"]["temp"].stringValue)
                print("使用了getWeather")
                print(json["now"]["temp"].stringValue)
            case .failure(let error):
                print(error)
            }
        }
    }
}

