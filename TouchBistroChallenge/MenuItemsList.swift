//
//  MenuItemsList.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import UIKit
import CoreData

class MenuItemsList: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuGroup: MenuGroupStore? = nil;
    var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadMenuItemsFromStore()
    }
    
    func loadMenuItemsFromStore() {
        // load items from CoreData and convert from CoreData objects to MenuItem objects
        var menuItems: [MenuItem] = []
        let fetchRequest: NSFetchRequest<MenuItemsStore> = MenuItemsStore.fetchRequest()
        do {
            let data: [MenuItemsStore] = try PersistanceService.context.fetch(fetchRequest)
            
            for item in data {
                if (item.menuGroup?.uuid == self.menuGroup?.uuid){
                    
                    let tempMenuItem = MenuItem(title: item.title!, image: UIImage(data: item.image!)!, price: item.price!, uuid: item.uuid!)
                    
                    // insert at top of list to ensure items appear in order of most recently added
                    menuItems.insert(tempMenuItem, at: 0)
                }
            }
            
        } catch {
            print("Error attemtping to find item when opening Menu List")
        }
        
        self.menuItems = menuItems
    }
    
    
    func addMenuItem(title: String, image: UIImage, price: String) {
        print("adding menuItem", title)
        
        let uuid = UUID().uuidString
        
        // add to core data
        let menuItemStore = MenuItemsStore(context: PersistanceService.context)
        menuItemStore.image = image.pngData()
        menuItemStore.title = title
        menuItemStore.price = price
        menuItemStore.uuid = uuid
        menuItemStore.menuGroup = self.menuGroup
        
        PersistanceService.saveContext()
        
        // add to MenuItem represtation of the list items
        let tempItem = MenuItem(title: title, image: image, price: price, uuid: uuid)
        menuItems.insert(tempItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        print("done", uuid)
        
    }
    
    @IBAction func unwindToMenuItemsList(_ sender: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "openEditor"){
            let destViewCtrl = segue.destination as! EditingScreen
            
                        // let editing view know menu group open so it can conditionally display the price field
            destViewCtrl.referrer = "items"
            
        }
    }
}

extension MenuItemsList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = menuItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! ItemCell
        
        cell.setMenuItem(menuItem: menuItem)
        
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
                if (item.uuid == menuItems[indexPath.row].uuid){
                    PersistanceService.context.delete(item)
                }
            }
            
            PersistanceService.saveContext()
            
        } catch {
            print("Error attemtping to delete item")
        }
        
        menuItems.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }    
}
