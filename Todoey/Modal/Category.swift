//
//  Data.swift
//  Todoey
//
//  Created by shree ram on 01/09/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
     @objc dynamic var colorHexValue : String = ""
    let items = List<Item>()
}
