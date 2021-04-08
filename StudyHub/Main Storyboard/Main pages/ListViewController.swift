//
//  ListViewController.swift
//  StudyHub
//
//  Created by Адель Рахимов on 06.04.2021.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    
    var lessons: [Discipline] = []
    
    var disciplines: [Discipline] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupTableView()
        
        self.disciplines = DBManager().getDisciplines()
        
//        lessons = [Discipline(id: 0, name: "Математика", icon: "icon"),
//                   Discipline(id: 1, name: "Информатика", icon: "icon"),
//                   Discipline(id: 2, name: "Численные методы", icon: "icon"),
//                   Discipline(id: 3, name: "Экономика", icon: "icon"),
//                   Discipline(id: 4, name: "Философия", icon: "icon")]
    }
    
//    let tableView = UITableView()
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubjectTableViewCell.self, forCellReuseIdentifier: "subjectCell")
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Предметы"
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toNewViewController))
    }
    
    @objc func toNewViewController() {
        performSegue(withIdentifier: "toNew", sender: nil)
    }
    
    
    @IBAction func returnToListViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "fromNew" {
            self.disciplines = DBManager().getDisciplines()
            tableView.reloadData()
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectTableViewCell
        cell.setup(name: disciplines[indexPath.row].name)
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dbManager: DBManager = DBManager()
            dbManager.deleteDiscipline(idValue: self.disciplines[indexPath.row].id)
            self.disciplines = DBManager().getDisciplines()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toLesson", sender: disciplines[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLesson", let lesson = sender as? Discipline, let dest = segue.destination as? LessonViewController {
            dest.discipline = lesson
        }
    }
}
