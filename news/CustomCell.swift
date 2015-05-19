//
//  CustomCell.swift
//  news
//
//  Created by kazan on 2015/05/18.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
