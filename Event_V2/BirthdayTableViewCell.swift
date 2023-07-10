//
//  BirthdayTableViewCell.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 19/11/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class BirthdayTableViewCell: UITableViewCell {
    @IBOutlet weak var birthdayNameLbl: UILabel!
    @IBOutlet weak var birthdayDateLbl: UILabel!
    @IBOutlet weak var birthdayDaysLbl: UILabel!
    
    @IBOutlet weak var eventColourIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
