//
//  TabBarViewController.swift
//  StudyHub
//
//  Created by Адель Рахимов on 06.04.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers![0].tabBarItem.title = "Предметы"
        viewControllers![1].tabBarItem.title = "Календарь"
        viewControllers![2].tabBarItem.title = "Расписание"
    }

    
    

}
