//
//  HomeScreenCell.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 29.05.2022.
//

import UIKit

class HomeScreenCell: UITableViewCell {

    @IBOutlet private var appSectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(withSectionName name: String) {
        appSectionNameLabel.text = name
    }
}
