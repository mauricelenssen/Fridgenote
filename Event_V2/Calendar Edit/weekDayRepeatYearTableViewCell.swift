//
//  weekDayRepeatTableViewCell.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 11/7/21.
//  Copyright © 2021 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class weekDayRepeatYearTableViewCell: UITableViewCell {
    @IBOutlet weak var weekDayRepeatLbl: UILabel!
    @IBOutlet weak var weekDayTickIV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
