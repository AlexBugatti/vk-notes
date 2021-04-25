//
//  NotesViewController.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class NotesViewController: UIViewController {

    var notes: [Note]  {
        return DatabaseService.shared.getNotes()
    }
    var filterNotes: [Note] {
        let categories = DatabaseService.shared.getCategories().filter({ $0.visible == true }).map({ $0.name })
        let fNotes = notes.filter { (note) -> Bool in
            return categories.contains(note.category)
        }
        self.placeholderLabel.isHidden = fNotes.count > 0
        return fNotes
    }
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var addPlusButton: UIButton! {
        didSet {
            self.addPlusButton.layer.cornerRadius = self.addPlusButton.frame.width / 2
            self.addPlusButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
            self.tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIBarButtonItem(title: "Категории", style: .plain, target: self, action: #selector(onDidCategoryTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "VK Notes"
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }

    @objc func onDidCategoryTapped() {
        let categoriesVC = CategoriesViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func onDidPlusTapped(_ sender: Any) {
        let noteVC = CreateNoteViewController()
        self.navigationController?.pushViewController(noteVC, animated: true)
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

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = self.filterNotes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCell
        cell.configure(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.filterNotes[indexPath.row]
        let noteVC = NoteViewController(note: note)
        self.navigationController?.pushViewController(noteVC, animated: true)
    }
    
}
