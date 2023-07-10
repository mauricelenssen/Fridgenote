//
//  ReminderTableViewCell.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 29/9/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    @IBOutlet weak var noteTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
