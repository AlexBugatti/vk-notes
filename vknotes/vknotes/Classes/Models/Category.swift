//
//  Category.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import RealmSwift

class Category: Object {

    @objc dynamic var name: String = ""
    @objc dynamic var visible: Bool = true
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
}
