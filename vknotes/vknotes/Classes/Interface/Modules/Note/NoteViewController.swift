//
//  NoteViewController.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class NoteViewController: UIViewController {

    var note: Note
    
    @IBOutlet private weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Заметка"
        setup(note: note)
        let editItem = UIBarButtonItem.init(title: "Действия", style: .plain, target: self, action: #selector(onDidEditTapped))
        self.navigationItem.setRightBarButton(editItem, animated: true)
        // Do any additional setup after loading the view.
    }

    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(note: Note) {
        let title = NSAttributedString.init(string: "\(note.title)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        let category = NSAttributedString.init(string: "\(note.category)\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let noteString = NSAttributedString(string: note.note, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        let attributedString = NSMutableAttributedString.init(attributedString: title)
        attributedString.append(category)
        attributedString.append(noteString)
        textView.attributedText = attributedString
    }
    
    func openActionSheet() {
        let actionSheet = UIAlertController.init(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction.init(title: "Редактировать", style: .default) { (action) in
            self.openEditController()
        }
        let deleteAction = UIAlertAction.init(title: "Удалить", style: .destructive) { (action) in
            self.removeNote()
        }
        let cancelAction = UIAlertAction.init(title: "Отмена", style: .cancel) { (action) in
            //
        }
        actionSheet.addAction(editAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openEditController() {
        let editVC = CreateNoteViewController(note: note)
        editVC.didUpdateNote = { note in
            self.setup(note: note)
        }
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func removeNote() {
        DatabaseService.shared.deleteNote(note: self.note)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onDidEditTapped() {
        openActionSheet()
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
