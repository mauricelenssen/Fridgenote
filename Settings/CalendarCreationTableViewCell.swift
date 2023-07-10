//
//  CalendarCreationTableViewCell.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 15/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class CalendarCreationTableViewCell: UITableViewCell {
    @IBOutlet weak var calendarNameLbl: UILabel!
    @IBOutlet weak var calendarTypeLbl: UILabel!
    @IBOutlet weak var calendarIDIv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
