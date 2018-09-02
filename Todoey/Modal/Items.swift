//
//  Items.swift
//  Todoey
//
//  Created by shree ram on 02/09/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
