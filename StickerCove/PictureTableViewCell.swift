//
//  PictureTableViewCell.swift
//  StickerCove
//
//  Created by Bruce Burgess on 12/24/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
