//
//  NewSubjectViewController.swift
//  StudyHub
//
//  Created by Адель Рахимов on 08.04.2021.
//

import UIKit

class NewDisciplineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTextField()
    }
    
    func setupNavigation() {
        title = "NEW"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func doneButtonPressed() {
        DBManager().addDiscipline(nameValue: nameTextField.text!, iconValue: "")
        performSegue(withIdentifier: "fromNew", sender: self)
    }
    
    let nameTextField: TextFieldWithPadding = {
        let view = TextFieldWithPadding()
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    func setupTextField() {
        view.addSubview(nameTextField)
        nameTextField.layer.cornerRadius = 5
        nameTextField.placeholder = "Placeholder"
        nameTextField.backgroundColor = .systemGray6
        nameTextField.delegate = self
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(50)
        }
    }


}

extension NewDisciplineViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "" {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
