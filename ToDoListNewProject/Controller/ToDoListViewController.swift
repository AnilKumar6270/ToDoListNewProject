//
//  ViewController.swift
//  ToDoListNewProject
//
//  Created by Anil on 11/08/19.
//  Copyright © 2019 ModeFin Server. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [itemDataModel]()
    
    var defaults = UserDefaults.standard
    
    //MARK:- View Start
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = itemDataModel()
        item.itemTitle = "First Element"
        itemArray.append(item)
        
        let item1 = itemDataModel()
        item1.itemTitle = "Second Element"
        itemArray.append(item1)

        let item2 = itemDataModel()
        item2.itemTitle = "Third Element"
        itemArray.append(item2)

        let item3 = itemDataModel()
        item3.itemTitle = "Fourth Element"
        itemArray.append(item3)

        let item4 = itemDataModel()
        item4.itemTitle = "Fifth Element"
        itemArray.append(item4)

        

        //        if let item = defaults.array(forKey: "ItemArray") as? [String] {
//            itemArray = item
       // }
        // Do any additional setup after loading the view.
    }
    //MARK: - Tableview Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.itemTitle
        
        if item.done == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.tableView.reloadData()
    }
    //MARK: - Add New Item
    @IBAction func addNewItemButtonPresses(_ sender: UIBarButtonItem) {
        var textFeild = UITextField()
        let alert = UIAlertController.init(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let newItem = itemDataModel()
            newItem.itemTitle = textFeild.text!
            self.itemArray.append(newItem)
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

