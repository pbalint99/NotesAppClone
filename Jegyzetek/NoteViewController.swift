//
//  ViewController.swift
//  Jegyzetek
//
//  Created by Péter Bálint on 2018. 08. 14..
//  Copyright © 2018. Péter Bálint. All rights reserved.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let realm = try! Realm()
    var thisItem : Item?
    var isNewItem : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = thisItem?.content
        textView.isEditable = true
        textView.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
//        if textView.text == "" {
//            do {
//                try realm.write {
//                    realm.delete(<#T##object: Object##Object#>)
//                }
//            } catch {print("ERROR 7")}
//        }
        saveItem()
        
    }

    func saveItem() {
        
        if isNewItem == true {
            
            do {
                try realm.write {
                    let newItem = Item()
                    realm.add(newItem)
                    newItem.content = textView.text
                    newItem.title = String(textView.text.prefix(40))
                    
                }

            } catch  {
                print("ERROR1: error saving text to realm")
            }
        }
            
        else
            
        {
            
            do {
                try realm.write {
                    thisItem?.content = textView.text
                    thisItem?.title = String(textView.text.prefix(40))
                }
            } catch { print ("ERROR5")}
            
        }
    }
    
    func titleGiver(item: Item) {
        
    }
    
}
