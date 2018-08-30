//
//  ViewController.swift
//  Todoey
//
//  Created by shree ram on 30/08/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
      var array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
         array = ["Travel", "Eat", "Sleep"]
        // Do any additional setup after loading the view, typically from a nib.
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoList")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"ToDoListCell" , for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    //Mark:- TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(array[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

