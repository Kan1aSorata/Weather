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
    private var i = 0;
    private var tempre = "等待请求.."
    var city: String? = " "{
        didSet {
            self.cityUrl = city
            self.testLabel.text = city
            model.addNewCityData(city!)
            if(city == "广西壮族自治区"){
                testLabel.font = UIFont.boldSystemFont(ofSize: 25)
            }else if(city == "澳门特别行政区"){
                testLabel.font = UIFont.boldSystemFont(ofSize: 25)
            }else if(city == "宁夏回族自治区"){
                testLabel.font = UIFont.boldSystemFont(ofSize: 25)
            }else if(city == "新疆维吾尔自治区"){
                testLabel.font = UIFont.boldSystemFont(ofSize: 24)
            }else if(city == "西藏自治区") {
                testLabel.font = UIFont.boldSystemFont(ofSize: 28)
            }else if(city == "香港特别行政区"){
                testLabel.font = UIFont.boldSystemFont(ofSize: 24)
            }else {
                testLabel.font = UIFont.boldSystemFont(ofSize: 40)
            }
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

    private let loadingView = UIActivityIndicatorView()
    private var weatherImageName: String?
    private let model = cityCoreDataModel()
    private let modelWeather = CoreDataModel()
    private var cityUrl: String?
    private var defaultLongtitude: String?
    private var defaultLatitude: String?
    private var testLabel = UILabel()
    private var testLabel1 = UILabel()
    private var testLabel2 = UILabel()
    private var weatherImageView = UIImageView()
    private let view2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadingView.backgroundColor = UIColor(displayP3Red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 0.3)
        self.view.addSubview(loadingView)
        title = "天气"
        tabBarItem.image = UIImage(systemName: "sun.haze")
        view2.backgroundColor = UIColor.init(red: 16/225, green: 78/225, blue: 139/225, alpha: 1)
        view2.layer.cornerRadius = 20
        view2.addSubview(testLabel1) //温度
        view2.addSubview(testLabel) //城市
        view2.addSubview(testLabel2) //feelsLike
        view2.addSubview(weatherImageView)
        view.addSubview(view2)
        testLabel.textColor = .white
        testLabel.shadowColor = .black
        testLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
        testLabel.adjustsFontSizeToFitWidth = true
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
        
        weatherImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(self.view.bounds.width * 3 / 4)
        }
        
        loadingView.center = view.center
        loadingView.hidesWhenStopped = true
        loadingView.style = UIActivityIndicatorView.Style.large
        view.addSubview(loadingView)
    }
    
    @objc func testFunc() {
        print(self.view2.bounds.height)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        getLocation() { [self] cityId -> Void in
            print(cityId)
            self.getWeather(cityId: cityId)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        model.deleteData()
    }
    
//    func getDefaultLocation(callBack: @escaping (String, String) -> Void){
//        let location = (defaultLongtitude ?? "") + "," + (defaultLatitude ?? "")
//        let parameters = ["key": "2277d865653b45f8af818efa55550d98", "location": location]
//            AF.request("https://geoapi.qweather.com/v2/city/lookup", method: .get, parameters: parameters).validate().responseJSON { responds in
//                switch responds.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    callBack((json["location"].arrayValue.first ?? [])["id"].stringValue, (json["location"].arrayValue.first ?? [])["name"].stringValue)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//
//    func getDefaultWeather(_ cityID: String, callBack: @escaping (String) -> Void){
//            let paramenters = ["key": "2277d865653b45f8af818efa55550d98", "location": cityID]
//            AF.request("https://devapi.qweather.com/v7/weather/now", method: .get, parameters: paramenters).validate().responseJSON {responds in
//                switch responds.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    callBack(json["now"]["temp"].string ?? "")
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
    
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
        loadingView.startAnimating()
        AF.request("https://devapi.qweather.com/v7/weather/now", method: .get, parameters: paramenters).validate().responseJSON { [self]responds in
            switch responds.result {
            case .success(let value):
                let json = JSON(value)
                //设置温度和对应图片
                self.testLabel1.font = UIFont.systemFont(ofSize: 80)
                self.testLabel1.text = json["now"]["temp"].stringValue
                self.weatherImageView.image = scaleImage(image: UIImage(named: json["now"]["icon"].stringValue)!, scalerFactor: 0.6)
            case .failure(let error):
                print(error)
            }
        }
        loadingView.stopAnimating()
    }
    
    func scaleImage(image:UIImage , scalerFactor: CGFloat)->UIImage{
            //        获得原图像的尺寸属性
            let imageSize = image.size
            //        获得原图像的宽度数值
            let width = imageSize.width
            //        获得原图像的高度数值
            let height = imageSize.height
            //        计算图像新的高度和宽度，并构成标准的CGSize对象
            let scaledWidth = width * scalerFactor
            let scaledHeight = height * scalerFactor
            let targetSize = CGSize(width: scaledWidth, height: scaledHeight)
            //        创建绘图上下文环境，
            UIGraphicsBeginImageContext(targetSize)
            image.draw(in: CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
            //        获取上下文里的内容，将视图写入到新的图像对象
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            return newImage!
        }
}

