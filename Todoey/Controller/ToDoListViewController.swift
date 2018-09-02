//
//  ViewController.swift
//  Todoey
//
//  Created by shree ram on 30/08/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoListViewController: UITableViewController {
    var array : Results<Item>?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
     let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"ToDoListCell" , for: indexPath)
        let item = array?[indexPath.row]
        cell.textLabel?.text = item?.title ?? "No Item Addwd Yet"
        cell.accessoryType = (item?.done)! ? .checkmark : .none
        return cell
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(array?[indexPath.row] as Any)
        if let item = array?[indexPath.row]{
            do{
                try self.realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error in Updating Item: \(error.localizedDescription)")
            }
        }
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - AddButtonAction
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField ()
        let alert = UIAlertController(title: "Add New ToDOListItem.", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Sucess")
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = "\(Date())"
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error in Saving Array \(error.localizedDescription)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
    }
    
    func save(item : Item) {
        do{
            try realm.write {
                realm.add(item)
            }
        } catch{
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    func loadItems() {
        array = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

}

extension ToDoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        array = array?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath:"dateCreated", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
