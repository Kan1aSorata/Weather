//
//  CityAdm2ViewController.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/12/3.
//

import Foundation
import UIKit
import CoreData

class CityAdm2ViewController: UIViewController {
    private let model = provinceCoreDataModel()
    private let model1 = cityCoreDataModel()
    private let provinceDic = ["北京": ["海淀区", "朝阳区", "顺义区", "怀柔区", "通州区", "昌平区", "延庆区", "丰台区", "石景山区", "大兴区", "房山区", "密云区", "门头沟区", "平谷区", "东城区", "西城区"]]
    var province: String? = "" {
        didSet {
            if let province = province {
                print("MARK5")
                print(province)
                model.addNewProvinceData(province)
                print("MARK4")
//                print(model.getProvinceData())
                print(model1.getCityData())
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "区"
        
        let screenRect = UIScreen.main.bounds
        let tableRect = CGRect(x: 0, y: 20, width: screenRect.width, height: screenRect.height - 20)
        let tableView = UITableView(frame: tableRect)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
    }
}

extension CityAdm2ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MARK3")
        print(model.getProvinceData())
        return provinceDic[model.getProvinceData()[0]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        cell?.textLabel!.text = provinceDic[model.getProvinceData()[0]]![indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherViewController = WeatherViewController()
    }
}
