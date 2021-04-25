//
//  CategoriesViewController.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    var categories: [Category] = DatabaseService.shared.getCategories() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    @IBOutlet weak var addCategoryButton: UIButton! {
        didSet {
            self.addCategoryButton.layer.cornerRadius = self.addCategoryButton.frame.width / 2
            self.addCategoryButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Категории"
        // Do any additional setup after loading the view.
    }
    
    func showCreatingAlert() {
        let ac = UIAlertController(title: "Введите категорию", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Создать", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            if let answer = answer.text, answer.isEmpty == false {
                var equals: [Category] = []
                if let first = self.categories.first(where: { $0.name == answer }) {
                    equals.append(first)
                }
                if equals.count == 0 {
                    DatabaseService.shared.addCategory(name: answer)
                    self.categories = DatabaseService.shared.getCategories()
                }
            }
            // do something interesting with "answer" here
        }
        let cancelAction = UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil)

        ac.addAction(submitAction)
        ac.addAction(cancelAction)

        present(ac, animated: true)
    }
    
    @IBAction func onDidCreateCategoryTapped(_ sender: Any) {
        showCreatingAlert()
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

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = category.name
        cell?.accessoryType = category.visible ? .checkmark : .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        DatabaseService.shared.editCategory(categoryObj: category, visible: !category.visible)
        categories = DatabaseService.shared.getCategories()
    }

}
