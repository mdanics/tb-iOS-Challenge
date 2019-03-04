//
//  MenuItemsStore+CoreDataProperties.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-04.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//
//

import Foundation
import CoreData


extension MenuItemsStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuItemsStore> {
        return NSFetchRequest<MenuItemsStore>(entityName: "MenuItemsStore")
    }

    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
    @NSManaged public var price: String?
    @NSManaged public var menuGroup: MenuGroupStore?

}
