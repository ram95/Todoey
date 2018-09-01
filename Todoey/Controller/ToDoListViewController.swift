//
//  ViewController.swift
//  Todoey
//
//  Created by shree ram on 30/08/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit
import CoreData
class ToDoListViewController: UITableViewController {
      var array = [Item]()
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
      let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//     let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("iteam.plist")
 //   let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
//        if let iteams = defaults.array(forKey: "ToDOListArray")  {
//            array =  iteams as! [String]
//        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"ToDoListCell" , for: indexPath)
        let item = array[indexPath.row]
        cell.textLabel?.text = item.tittle
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(array[indexPath.row])
        array[indexPath.row].done = !array[indexPath.row].done
    
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    //MARK: - AddButtonAction
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField ()
        let alert = UIAlertController(title: "Add New ToDOListItem.", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Sucess")
            let item = Item(context: self.contex)
//            let item = Item()
            item.tittle = textField.text!
            item.done = false
            item.parentCategory = self.selectedCategory
            self.array.append(item)
            self.saveItems()
//            self.array.append(textField.text!)
//            self.defaults.set(self.array, forKey: "ToDOListArray")
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
    }
    func saveItems() {
        do{
          try contex.save()
        } catch{
            print(error.localizedDescription)
        }
        
//        let encoder = PropertyListEncoder ()
//        do {
//            let data = try encoder.encode(array)
//            try data.write(to: dataFile!)
//        } catch {
//            print("Error encoding Array \(error.localizedDescription)")
//        }
        tableView.reloadData()
    }
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        if let addtionalPredicate = predicate {
            request.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        } else{
            request.predicate = categoryPredicate
        }
        do{
            array = try contex.fetch(request)
        }catch {
            print("Error Loding Array \(error.localizedDescription)")
        }
//        if  let data = try? Data(contentsOf: dataFile!){
//            let decoder = PropertyListDecoder ()
//            do{
//                array = try decoder.decode([Item].self, from:data)
//            } catch {
//                print("Error Loding Array \(error.localizedDescription)")
//            }
//        }
        tableView.reloadData()
    }

}

extension ToDoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "tittle CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "tittle", ascending: true)]
        loadItems(with: request, predicate: predicate)
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
