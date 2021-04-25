//
//  DatabaseService.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import RealmSwift

class DatabaseService: NSObject {

    static let shared = DatabaseService()
    
    let localRealm = try! Realm()
    
    func getNotes() -> [Note] {
        var notes: [Note] = []
        localRealm.objects(Note.self).forEach({ notes.append($0) })
        return notes
    }
    
    func getCategories() -> [Category] {
        var categories: [Category] = []
        localRealm.objects(Category.self).forEach({ categories.append($0) })
        return categories
    }
    
    func addNote(title: String, category: String, note: String) {
        let note = Note(title: title, note: note, category: category)
        try! localRealm.write {
            localRealm.add(note)
        }
    }
    
    func deleteNote(note: Note) {
        try! localRealm.write {
            localRealm.delete(note)
        }
    }
    
    func editNote(noteObj: Note, title: String, category: String, note: String) {
        try! localRealm.write {
            noteObj.title = title
            noteObj.category = category
            noteObj.note = note
        }
    }
    
    func addCategory(name: String) {
        let category = Category(name: name)
        try! localRealm.write {
            localRealm.add(category)
        }
    }
    
    func editCategory(categoryObj: Category, visible: Bool) {
        try! localRealm.write {
            categoryObj.visible = visible
        }
    }
    
}
