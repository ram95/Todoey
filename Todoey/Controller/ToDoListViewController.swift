//
//  ViewController.swift
//  Todoey
//
//  Created by shree ram on 30/08/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
      var array = [Item]()
 //   let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

      //  array.app
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoList")
//        if let iteams = defaults.array(forKey: "ToDOListArray")  {
//            array =  iteams as! [String]
//        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"ToDoListCell" , for: indexPath)
        let iteam = array[indexPath.row]
        cell.textLabel?.text = iteam.tittle
        cell.accessoryType = iteam.isDone ? .checkmark : .none
        return cell
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(array[indexPath.row])
        array[indexPath.row].isDone = !array[indexPath.row].isDone
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - AddButtonAction
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField ()
        let alert = UIAlertController(title: "Add New ToDOListItem.", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Sucess")
            let item = Item()
            item.tittle = textField.text!
            self.array.append(item)
//            self.array.append(textField.text!)
//            self.defaults.set(self.array, forKey: "ToDOListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
    }
    
}

