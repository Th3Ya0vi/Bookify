//
//  MessagesTableViewCell.swift
//  Bookify
//
//  Created by Neal Patel on 4/6/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var messageHolder: UILabel!
    @IBOutlet weak var userSendingMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
