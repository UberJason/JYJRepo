//
//  TwoLabelTableViewCell.swift
//  JYJ Helper
//
//  Created by Jason Ji on 6/15/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

import UIKit

class TwoLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    required init?(coder:NSCoder) {
        super.init(coder:coder);
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
