//
//  File.swift
//  Jegyzetek
//
//  Created by Péter Bálint on 2018. 08. 14..
//  Copyright © 2018. Péter Bálint. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    
}
