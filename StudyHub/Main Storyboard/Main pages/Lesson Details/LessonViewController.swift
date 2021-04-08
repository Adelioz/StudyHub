//
//  LessonViewController.swift
//  StudyHub
//
//  Created by Адель Рахимов on 06.04.2021.
//

import UIKit

class LessonViewController: UIViewController {
    
    var discipline: Discipline = Discipline()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = discipline.name
        navigationController!.navigationItem.title = discipline.name
    }
    
    
    

    

}
