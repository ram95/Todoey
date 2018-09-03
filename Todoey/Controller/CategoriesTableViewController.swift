//
//  CategoriesTableViewController.swift
//  Todoey
//
//  Created by shree ram on 01/09/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class CategoriesTableViewController: SwipeTableViewController {
    var CategoriesArr : Results<Category>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesArr?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let currentCategory = CategoriesArr?[indexPath.row] {
        cell.textLabel?.text = currentCategory.name
        guard let color  = UIColor(hexString:currentCategory.colorHexValue ) else {fatalError("Error")}
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        } else {
            cell.textLabel?.text = "No Category Added Yet!"
            cell.backgroundColor = UIColor(hexString: "1D9BFC")
        }
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func updateModal(at indexPath: IndexPath) {
        if let category = CategoriesArr?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("Error in Deleting Item: \(error.localizedDescription)")
            }
            
        }
    }
    
   
    
    
     // MARK: - Navigation
     

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = CategoriesArr?[indexPath.row]
        }
     }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category?", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            print(textField.text!)
           // let category = Category(context: self.context)
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colorHexValue = UIColor.randomFlat.hexValue()
            self.save(category:newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK: - UpdateDatabase:
    
        func save(category: Category) {
        do{
            try realm.write {
                 realm.add(category)
            }
        } catch{
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    func loadCategory() {
            CategoriesArr = realm.objects(Category.self)
        tableView.reloadData()
    }
}
