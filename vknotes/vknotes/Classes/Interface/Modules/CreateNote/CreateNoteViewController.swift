//
//  CreateNoteViewController.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import DropDown

class CreateNoteViewController: UIViewController {

    var didUpdateNote: ((Note) -> Void)?
    var note: Note?
    
    init(note: Note? = nil) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var categoryView: UIView! {
        didSet {
            categoryView.layer.borderWidth = 0.5
            categoryView.layer.borderColor = #colorLiteral(red: 0.7999381423, green: 0.8000349402, blue: 0.7999051213, alpha: 1)
            categoryView.layer.cornerRadius = 5
            categoryView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.layer.borderWidth = 0.5
            textView.layer.borderColor = #colorLiteral(red: 0.7999381423, green: 0.8000349402, blue: 0.7999051213, alpha: 1)
            textView.layer.cornerRadius = 5
            textView.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title = note == nil ? "Новая заметка" : "Редактирование"
        self.navigationItem.title = title
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDidCategoryTapped))
        self.categoryView.addGestureRecognizer(tapRecognizer)
        categoryLabel.text = "Выберите категорию"
        
        if let note = note {
            textView.text = note.note
            textFiled.text = note.title
            categoryLabel.text = note.category
        }
        
        let editItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(onDidSaveTapped))
        self.navigationItem.setRightBarButton(editItem, animated: true)
        // Do any additional setup after loading the view.
    }

    @objc func onDidCategoryTapped() {
        let dropDown = DropDown.init(anchorView: categoryView)
        let categories = DatabaseService.shared.getCategories()
        dropDown.dataSource = categories.map({ $0.name })
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryLabel.text = item
        }
        dropDown.show()
        
    }
    
    @objc func onDidSaveTapped() {
        
        guard let title = textFiled.text, title.isEmpty == false, textView.text.isEmpty == false, categoryLabel.text != "Выберите категорию" else {
            let alert = UIAlertController(title: nil, message: "Данные не корректно заполнены", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let note = note {
            DatabaseService.shared.editNote(noteObj: note, title: title, category: categoryLabel.text ?? "", note: textView.text)
            self.didUpdateNote?(note)
        } else {
            DatabaseService.shared.addNote(title: title, category: categoryLabel.text ?? "", note: textView.text)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
