//
//  WeatherViewController.swift
//  Weather
//
//  Created by 贺峰煜 on 2020/11/3.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    var city: String? = ""
    {
        didSet {
            self.label.text = city
        }
    }
    private var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "天气"
        tabBarItem.image = UIImage(systemName: "sun.haze")
        
        label.frame = CGRect(x: 10, y: 100, width: 200, height: 150)
        label.text = city
        label.backgroundColor = .yellow
        label.textColor = .black
        view.addSubview(label)
    }
}
