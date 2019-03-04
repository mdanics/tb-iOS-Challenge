//
//  MenuGroupStore+CoreDataProperties.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//
//

import Foundation
import CoreData


extension MenuGroupStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuGroupStore> {
        return NSFetchRequest<MenuGroupStore>(entityName: "MenuGroupStore")
    }

    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
    @NSManaged public var items: NSOrderedSet?

}

// MARK: Generated accessors for items
extension MenuGroupStore {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: MenuItemsStore, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [MenuItemsStore], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: MenuItemsStore)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [MenuItemsStore])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: MenuItemsStore)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: MenuItemsStore)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}
