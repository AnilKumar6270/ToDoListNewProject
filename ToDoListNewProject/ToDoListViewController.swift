//
//  ViewController.swift
//  ToDoListNewProject
//
//  Created by Anil on 11/08/19.
//  Copyright © 2019 ModeFin Server. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogogorgan"]
    var defaults = UserDefaults.standard
    
    //MARK:- View Start
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "ItemArray") as? [String] {
            itemArray = item
        }
        // Do any additional setup after loading the view.
    }
    //MARK: - Tableview Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    //MARK: - Add New Item
    @IBAction func addNewItemButtonPresses(_ sender: UIBarButtonItem) {
        var textFeild = UITextField()
        let alert = UIAlertController.init(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textFeild.text!)
            self.defaults.set(self.itemArray, forKey: "ItemArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new item"
            textFeild = alertTextFeild
        }
        alert .addAction(alertAction)
        present(alert,animated: true,completion: nil)
    }
    
    
}

