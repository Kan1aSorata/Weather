//
//  WeatherViewController.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/3.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    var city: String?
    private let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "天气"
        self.tabBarItem.image = UIImage(systemName: "sun.haze")
        
        label.frame = CGRect(x: 10, y: 100, width: 200, height: 150)
        label.backgroundColor = .yellow
        label.textColor = .black
        self.view.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.label.text = city
    }
}
