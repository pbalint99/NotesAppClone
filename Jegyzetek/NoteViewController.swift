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
    let thisItem = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = thisItem.content
        textView.isEditable = true
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: true) {
            self.saveItem()
        }
    }

    func saveItem() {
        
        do {
            try realm.write {
                thisItem.content = textView.text
            }
        } catch  {
            print("ERROR1: error saving text to realm")
        }
    }

}

