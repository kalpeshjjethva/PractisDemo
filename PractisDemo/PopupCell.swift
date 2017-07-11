//
//  PopupCell.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 11/07/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit

class PopupCell: UITableViewCell {

    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPropertyDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
