//
//  CustomTableViewCell.swift
//  Dropdown-menu
//
//  Created by Dhruvil Patel on 3/18/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topCountryButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topCountryButtonOutlet.layer.cornerRadius = 5
        topCountryButtonOutlet.setTitle("Top country"+"\n"+"for product", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
