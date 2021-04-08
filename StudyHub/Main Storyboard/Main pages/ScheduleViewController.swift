//
//  ScheduleViewController.swift
//  StudyHub
//
//  Created by Адель Рахимов on 06.04.2021.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "Расписание"
        navigationItem.title = "Расписание"
    }

}
