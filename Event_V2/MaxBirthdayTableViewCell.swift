//
//  MaxBirthdayTableViewCell.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 20/11/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class MaxBirthdayTableViewCell: UITableViewCell {
    @IBOutlet weak var birthdayNameLbl: UILabel!
    @IBOutlet weak var birthdayDateLbl: UILabel!
    @IBOutlet weak var birthdayDaysLbl: UILabel!
    
    @IBOutlet weak var eventColourIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
