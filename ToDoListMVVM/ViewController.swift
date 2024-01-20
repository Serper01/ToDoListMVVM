//
//  ViewController.swift
//  ToDoListMVVM
//
//  Created by Serper Kurmanbek on 19.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    
    var viewModel: TaskViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = TaskViewModel { [unowned self] (state) in
            switch state.editingStyle {
            case .addTask(_):
                textField.text = ""
                break
            case .deleteTask(_):
                break
            case .toggleTask(_):
                break
            case .loadTasks(_):
                break
            case .none:
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadTasks()
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        viewModel?.addNewTask(taskName: textField.text!)
    }


}


