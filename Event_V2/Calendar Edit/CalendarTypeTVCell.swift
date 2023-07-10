//
//  CalendarTypeTVCell.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 31/3/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class CalendarTypeTVCell: UITableViewCell {
    @IBOutlet weak var calendarTypeLbl: UILabel!
    @IBOutlet weak var calendarTypeImg: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    //@IBOutlet weak var calendarTickImg: UIImageView!
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
