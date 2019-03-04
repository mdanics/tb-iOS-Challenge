//
//  MenuGroup.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import Foundation
import UIKit


class MenuGroup {
    var title: String
    var image: UIImage
    var uuid: String

    
    init(title: String, image: UIImage, uuid: String){
        self.title = title
        self.image = image
        self.uuid = uuid
    }
}
