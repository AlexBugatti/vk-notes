//
//  Note.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import RealmSwift

class Note: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var note: String = ""
    @objc dynamic var category: String = "Default"
    
    convenience init(title: String, note: String, category: String) {
        self.init()
        self.title = title
        self.note = note
        self.category = category
    }
    
}
