//
//  JYJTripTableViewCell.swift
//  JYJ Helper
//
//  Created by Jason Ji on 6/12/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

import UIKit

class JYJTripTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel : UILabel
    @IBOutlet var startDateLabel : UILabel
    @IBOutlet var endDateLabel : UILabel
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
