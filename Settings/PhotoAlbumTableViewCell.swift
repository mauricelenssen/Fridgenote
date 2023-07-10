//
//  PhotoAlbumTableViewCell.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 21/2/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class PhotoAlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var photoAlbumNameLbl: UILabel!
    @IBOutlet weak var photoAlbumTypeLbl: UILabel!
    @IBOutlet weak var photoAlbumSelectionIv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
