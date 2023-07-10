//
//  MyCustomCell.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 19/11/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventTimeLbl: UILabel!
    @IBOutlet weak var calendarTypeImg2: UIImageView!
    //@IBOutlet weak var infoImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
