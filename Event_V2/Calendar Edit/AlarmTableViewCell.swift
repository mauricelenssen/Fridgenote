//
//  AlarmTableViewCell.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 7/9/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    @IBOutlet weak var alarmLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
