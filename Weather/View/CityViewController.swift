//
//  CityViewController.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/3.
//

import Foundation
import UIKit

class CityViewController: UIViewController {
    var countries
        = ["A":["安徽", "澳门特别行政区"], "B":["北京"], "C":["重庆"], "F":["福建"], "G":["甘肃", "贵州", "广西壮族自治区", "广东"], "H":["黑龙江", "河北", "河南", "湖北", "湖南", "海南"], "J":["吉林", "江苏", "江西"], "L":["辽宁"], "N":["内蒙古", "宁夏回族自治区"], "Q":["青海"], "S":["上海", "山西", "陕西", "山东", "四川"], "T":["天津", "台湾"], "X":["新疆维吾尔自治区", "西藏自治区", "香港特别行政区"], "Y":["云南"], "Z":["浙江"]]
    var keys:[String] = []
    private var model = cityCoreDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "省份"
        self.view.backgroundColor = .white
        
        keys = Array(countries.keys).sorted()
        
        let screenRect = UIScreen.main.bounds
        let tableRect = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        let tableView = UITableView(frame: tableRect)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        self.view.backgroundColor = UIColor.white
        self.title = "城市"
        self.tabBarItem.image = UIImage(systemName: "house")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subCountries = countries[keys[section]]
        return (subCountries?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        
        let subCountries = countries[keys[(indexPath as NSIndexPath).section]]
        cell?.textLabel?.text = subCountries![(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.deleteData()
        let cityAdmViewController = CityAdmViewController()
        cityAdmViewController.city = countries[keys[(indexPath as NSIndexPath).section]]![indexPath.row]
        model.addNewCityData(countries[keys[(indexPath as NSIndexPath).section]]![indexPath.row])
        print("MARKK1")
        print(model.getCityData())
        print(countries[keys[(indexPath as NSIndexPath).section]]![indexPath.row])
        navigationController?.pushViewController(CityAdmViewController(), animated: true)
        
//        if let controllers = tabBarController?.viewControllers {
//            let weatherViewController = controllers[1] as? WeatherViewController
//            weatherViewController?.city = countries[keys[(indexPath as NSIndexPath).section]]![indexPath.row]
//        }
//        self.tabBarController?.selectedIndex = 1
    }
}
