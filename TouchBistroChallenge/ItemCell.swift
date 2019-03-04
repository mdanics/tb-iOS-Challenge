//
//  ItemCell.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    
    func setMenuItem(menuItem: MenuItem){
        itemImageView.image = menuItem.image
        itemTitleLabel.text = menuItem.title
        itemPriceLabel.text = menuItem.price
    }
}
