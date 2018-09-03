//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by shree ram on 02/09/18.
//  Copyright © 2018 shree ram. All rights reserved.
//

import UIKit
import SwipeCellKit
class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
           self.updateModal(at: indexPath)
    }
        deleteAction.image = UIImage(named:"delete-Icon" )
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModal(at indexPath : IndexPath)  {
        
    }
        
    
}
