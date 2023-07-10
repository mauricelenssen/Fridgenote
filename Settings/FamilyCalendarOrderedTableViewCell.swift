//
//  FamilyCalendarOrderedTableViewCell.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 18/3/2023.
//  Copyright © 2023 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class FamilyCalendarOrderedTableViewCell: UITableViewCell {
    @IBOutlet weak var calendarNameLbl: UILabel!
    @IBOutlet weak var calendarTypeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
