//
//  ChatMenuTableViewCell.swift
//  Bookify
//
//  Created by Neal Patel on 4/20/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

class ChatMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var otherSenderAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mostRecentMessageDateTextField: UITextField!
    @IBOutlet weak var messagePreviewTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
