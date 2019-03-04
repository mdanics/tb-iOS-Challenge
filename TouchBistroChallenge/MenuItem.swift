//
//  MenuItem.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import Foundation
import UIKit


class MenuItem {
    var title: String
    var image: UIImage
    var uuid: String
    var price: String
    
    
    init(title: String, image: UIImage, price: String, uuid: String){
        self.title = title
        self.image = image
        self.price = price
        self.uuid = uuid
    }
}
