//
//  ListTableViewController.swift
//  Jegyzetek
//
//  Created by Péter Bálint on 2018. 08. 14..
//  Copyright © 2018. Péter Bálint. All rights reserved.
//

import UIKit
import ChameleonFramework
import RealmSwift
import SwipeCellKit



class ListTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var itemArray : Results<Item>?
    let realm = try! Realm()
    var isNewItem : Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = itemArray?[indexPath.row].title ?? ""
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isNewItem = false
        performSegue(withIdentifier: "goToNote", sender: self)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            do {
                try self.realm.write {
                    self.realm.delete(self.itemArray![indexPath.row])
                }
            } catch {print("ERROR6")}
        }
        
        // customize the action appearance
        //deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isNewItem == true {
        let newItem = Item()
        do {
            try realm.write {
                realm.add(newItem)
            }
        } catch  {
            print("ERROR2: Error adding new item")
        }
        }
        else {
            let destinationVC = segue.destination as! NoteViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.thisItem = itemArray?[indexPath.row]
                destinationVC.isNewItem = false
            }
        }
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToNote", sender: self)
        
    }
    
    func loadItems() {
        
        itemArray = realm.objects(Item.self)
        tableView.reloadData()
        
    }
    
    
}







