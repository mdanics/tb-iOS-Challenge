//
//  MenuGroupList.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import UIKit
import CoreData


class MenuGroupList: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var menuGroups: [MenuGroup] = []
    
    var tappedMenuGroupItem: MenuGroupStore? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let fetchRequest: NSFetchRequest<MenuGroupStore> = MenuGroupStore.fetchRequest()
        do {
            let data: [MenuGroupStore] = try PersistanceService.context.fetch(fetchRequest)
            self.convertCoreDataToUI(data: data)
        } catch {
            print("Data was not found")
        }
    }
    
    func convertCoreDataToUI(data: [MenuGroupStore]){
        
        // loop through the Core Data store of Menu Groups and convert to MenuGroup class for cleaner connection to UI
        var menuGroupItems: [MenuGroup] = []
        for item in data{
            let tempItem: MenuGroup = MenuGroup(title: item.title!, image: UIImage(data: item.image!)!, uuid: item.uuid!)
            menuGroupItems.append(tempItem)
        }
        
        // reverse the items so that they appear in order of most recently added
        menuGroupItems.reverse()
        
        self.menuGroups = menuGroupItems
    }

    func addMenuGroup(title: String, image: UIImage) {
        print("adding menuGroup", title)
        
        let uuid = UUID().uuidString
        
        // add to Core Data
        let menuGroupStoreItem = MenuGroupStore(context: PersistanceService.context)
        menuGroupStoreItem.image = image.pngData()
        menuGroupStoreItem.title = title
        menuGroupStoreItem.uuid = uuid
        
        PersistanceService.saveContext()
    
        // add to MenuGroup representation of the list items
        let tempItem = MenuGroup(title: title, image: image, uuid: uuid)
        menuGroups.insert(tempItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    func openMenuItemsList(tappedItem: MenuGroup) {
        var menuGroupStoreItem: MenuGroupStore? = nil;
        
        let fetchRequest: NSFetchRequest<MenuGroupStore> = MenuGroupStore.fetchRequest()
        do {
            let data: [MenuGroupStore] = try PersistanceService.context.fetch(fetchRequest)
            // find matching MenuGroup item in Core Data which is later used to assign the relationship between a MenuItem and MenuGroup Item
            for item in data {
                if (item.uuid == tappedItem.uuid){
                    menuGroupStoreItem = item
                }
            }
            
        } catch {
            print("Error attemtping to find item when opening Menu List")
        }
        
        self.tappedMenuGroupItem = menuGroupStoreItem

        
        performSegue(withIdentifier: "openMenuItems", sender: Any?.self)
    }
    
    @IBAction func unwindToMenuGroupList(_ sender: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "openMenuItems" && self.tappedMenuGroupItem != nil) {
            let destViewCtrl = segue.destination as! MenuItemsList
            
            // assign the tapped menu group to the menu items view
            destViewCtrl.menuGroup = self.tappedMenuGroupItem!
            
        } else if (segue.identifier == "openEditor"){
            let destViewCtrl = segue.destination as! EditingScreen
            // let editing view know menu group open so it can conditionally display the price field
            destViewCtrl.referrer = "group"

        }
    }
}

extension MenuGroupList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuGroup = menuGroups[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuGroupCell") as! GroupCell
        
        cell.setMenuGroup(menuGroup: menuGroup)
        
        return cell
    }
    
    // handle swipe to delete an item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        
        // delete from core data
        let fetchRequest: NSFetchRequest<MenuGroupStore> = MenuGroupStore.fetchRequest()
        do {
            let data: [MenuGroupStore] = try PersistanceService.context.fetch(fetchRequest)
            
            for item in data {
                if (item.uuid == menuGroups[indexPath.row].uuid){
                    PersistanceService.context.delete(item)
                }
            }
            
            PersistanceService.saveContext()
            
        } catch {
            print("Error attemtping to delete item")
        }
        
        // delete from MenuGroup list
        menuGroups.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped row")
        let menuGroupItem = menuGroups[indexPath.row]
        print("row selected" + menuGroupItem.title)
        
        openMenuItemsList(tappedItem: menuGroupItem)
    }
    
}
