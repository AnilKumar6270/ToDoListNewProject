//  ViewController.swift
//  ToDoListNewProject
//  Created by Anil on 11/08/19.
//  Copyright © 2019 ModeFin Server. All rights reserved.
import UIKit
import CoreData
class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    //MARK:- View Start
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //MARK: - Tableview Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.item
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveFile()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Add New Item
    @IBAction func addNewItemButtonPresses(_ sender: UIBarButtonItem) {
        var textFeild = UITextField()
        let alert = UIAlertController.init(title: "Add New TodoList Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.item = textFeild.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    //MARK: - Save File
    func saveFile () {
        do {
            try self.context.save()
        }
        catch {
            print("error Saving \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems (with request : NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("error fetching item from data model")
        }
        tableView.reloadData()
    }
}
extension ToDoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "item", ascending: true)]
        
        loadItems(with: request)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel button clicked")
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

