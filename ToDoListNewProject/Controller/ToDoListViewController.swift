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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    
    //MARK:- View Start
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
        
        //This is for user defaults value storage
//        if let item = defaults.array(forKey: "ItemArray") as? [itemDataModel] {
//            itemArray = item
//        }
        // Do any additional setup after loading the view.
    }
    //MARK: - Tableview Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.itemTitle
        
        //Ternary Operator
       // cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        
        //Normal Conditions
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveFile()
    }
    //MARK: - Add New Item
    @IBAction func addNewItemButtonPresses(_ sender: UIBarButtonItem) {
        var textFeild = UITextField()
        let alert = UIAlertController.init(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let newItem = itemDataModel()
            newItem.itemTitle = textFeild.text!
            self.itemArray.append(newItem)
            
            self.saveFile()
        }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new item"
            textFeild = alertTextFeild
        }
        alert .addAction(alertAction)
        present(alert,animated: true,completion: nil)
    }
    
    func saveFile () {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }
        catch {
            print("error exicuted \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems () {
       
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder ()
            do {
                itemArray = try decoder.decode([itemDataModel].self, from: data)
            }
            catch {
                print("exicute error \(error)")
            }
        }
       
    }
}

