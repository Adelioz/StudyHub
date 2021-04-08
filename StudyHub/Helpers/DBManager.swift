//
//  DBManager.swift
//  StudyHub
//
//  Created by Адель Рахимов on 08.04.2021.
//

import Foundation
import SQLite

class DBManager {
    private var db: Connection!
    private var disciplines: Table!
    
    private var id: Expression<Int>!
    private var name: Expression<String>!
    private var icon: Expression<String>!
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/disciplines_sqlite3")
            disciplines = Table("disciplines")
            
            id = Expression<Int>("id")
            name = Expression<String>("name")
            icon = Expression<String>("icon")
            
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                try db.run(disciplines.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(icon)
                })
                
                UserDefaults.standard.setValue(true, forKey: "is_db_created")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func addDiscipline(nameValue: String, iconValue: String) {
        do {
            try db.run(disciplines.insert(name <- nameValue, icon <- iconValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getDisciplines() -> [Discipline] {
        var disciplinesArr: [Discipline] = []
        self.disciplines = self.disciplines.order(id.desc)
        
        do {
            for discipline in try db.prepare(disciplines) {
                let disciplineModel: Discipline = Discipline()
                disciplineModel.id = discipline[id]
                disciplineModel.name = discipline[name]
                disciplineModel.icon = discipline[icon]
                
                disciplinesArr.append(disciplineModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return disciplinesArr
    }
    
    public func deleteDiscipline(idValue: Int) {
        do {
            let discipline: Table = disciplines.filter(id == idValue)
            try db.run(discipline.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getDiscipline(idValue: Int) -> Discipline {
        let disciplineModel: Discipline = Discipline()
        
        do {
            let discipline: AnySequence<Row> = try db.prepare(disciplines.filter(id == idValue))
            try discipline.forEach({ (rowValue) in
                disciplineModel.id = try rowValue.get(id)
                disciplineModel.name = try rowValue.get(name)
                disciplineModel.icon = try rowValue.get(icon)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        return disciplineModel
    }
    
    public func updateDiscipline(idValue: Int, nameValue: String) {
        do {
            let discipline: Table = disciplines.filter(id == idValue)
            try db.run(discipline.update(name <- nameValue))
            //UPDATE FUNC
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
