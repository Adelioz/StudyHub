//
//  SubjectTableViewCell.swift
//  StudyHub
//
//  Created by Адель Рахимов on 06.04.2021.
//

import UIKit
import SnapKit

class SubjectTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let iconLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setup(name: String) {
        self.addSubview(iconLabel)
        iconLabel.backgroundColor = .red
        iconLabel.snp.makeConstraints { (make) in
            make.height.width.equalTo(self.bounds.height / 3)
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.bounds.height / 4)
        }
        
        self.addSubview(nameLabel)
        nameLabel.text = name
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(iconLabel.snp.trailing).offset(self.bounds.height / 4)
        }
//        icon.snp.makeConstraints(
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
