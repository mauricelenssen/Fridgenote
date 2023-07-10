//
//  upcommingEventTableViewCell.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 7/6/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class upcommingEventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventDateLbl: UILabel!
    @IBOutlet weak var eventDaysLbl: UILabel!
    
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
