//
//  CityAdmViewController.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/12/3.
//

import Foundation
import UIKit
import CoreData

class CityAdmViewController: UIViewController {
    private var model = cityCoreDataModel()
    var city: String? = "" {
        didSet {
            if let city = city {
                model.deleteData()
                print("MARK")
                print(model.getCityData())
            }
        }
    }
    private let cityAdmDic = ["北京": ["北京"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "城市"
        
        let screenRect = UIScreen.main.bounds
        let tableRect = CGRect(x: 0, y: 20, width: screenRect.width, height: screenRect.height - 20)
        let tableView = UITableView(frame: tableRect)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
}

extension CityAdmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MARK2")
        print(model.getCityData())
        return cityAdmDic[model.getCityData()[0]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        cell?.textLabel!.text = cityAdmDic[model.getCityData()[0]]![indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityAdm2ViewController = CityAdm2ViewController()
        cityAdm2ViewController.province = cityAdmDic[model.getCityData().first!]![indexPath.row]
        navigationController?.pushViewController(CityAdm2ViewController(), animated: true)
    }
}
