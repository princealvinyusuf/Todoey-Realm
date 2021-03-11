//
//  Category.swift
//  Todoey
//
//  Created by Prince Alvin Yusuf on 10/03/21.
//  Copyright © 2021 Prince Alvin Yusuf. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    // Relationship "to many"
    let items = List<Item>()
}
