//
//  GroupCell.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    func setMenuGroup(menuGroup: MenuGroup){
        groupImageView.image = menuGroup.image
        groupTitleLabel.text = menuGroup.title
    }
}
