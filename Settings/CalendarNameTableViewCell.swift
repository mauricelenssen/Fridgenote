//
//  CalendarNameTableViewCell.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 20/2/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class CalendarNameTableViewCell: UITableViewCell {
    @IBOutlet weak var calendarNameLbl: UILabel!
    @IBOutlet weak var calendarTypeLbl: UILabel!
    @IBOutlet weak var calendarSelectionIv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
