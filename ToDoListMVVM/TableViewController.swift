//
//  TableViewController.swift
//  ToDoListMVVM
//
//   Created by Serper Kurmanbek on 20.01.2024.
//

import UIKit

class TableViewController: UITableViewController {

    var viewModel: TaskViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
            viewModel = TaskViewModel { [unowned self] (state) in
                switch state.editingStyle {
                case .addTask(_):
                    self.tableView.reloadData()
                    break
                case .deleteTask(_):
                    break
                case .toggleTask(_):
                    self.tableView.reloadData()
                    break
                case .loadTasks(_):
                    self.tableView.reloadData()
                    break
                case .none:
                    self.tableView.reloadData()
                    break
                }
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.loadTasks()
    }
    
    //        defaults.set(arrayTask, forKey: "taskArray")
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (viewModel?.state.todolistarray.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default , reuseIdentifier: "cell")
        
        cell.textLabel?.text = viewModel?.state.text(at: indexPath)
        cell.accessoryType = (viewModel?.accessoryType(at: indexPath))!
        
        //        cell.detailTextLabel?.text = arrayTask[indexPath.row].name
        
//        if arrayTask[indexPath.row].isComplete {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.toggleTask(at: indexPath)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel?.deleteTask(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
