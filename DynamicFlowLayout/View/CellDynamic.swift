//
//  CellDynamic.swift
//  DynamicFlowLayout
//
//  Created by Shankar on 18/01/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class CellDynamic: UITableViewCell {

    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var labelProfileDesc: UILabel!
    @IBOutlet weak var labelProfileName: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
