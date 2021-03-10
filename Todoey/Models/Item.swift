//
//  Item.swift
//  Todoey
//
//  Created by Prince Alvin Yusuf on 10/03/21.
//  Copyright © 2021 Prince Alvin Yusuf. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
