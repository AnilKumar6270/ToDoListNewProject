//
//  CategoryViewController.swift
//  ToDoListNewProject
//
//  Created by Anil on 24/08/19.
//  Copyright © 2019 ModeFin Server. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategories()
    }
    //MARK: - Tableview Datasource Method's
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //MARK: - Tableview Delegate Method's
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if  let indexpath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories[indexpath.row]
        }
        
    }
    //MARK: - Data Manipulation Method's
    func loadCategories () {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categories = try context.fetch(request)
        }
        catch {
            print("Error While Fetching Data")
        }
        
    }
    //MARK: - Add new Item to Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField  = UITextField()
        let alert = UIAlertController.init(title: "Add New Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            self.categories.append(newItem)
            self.saveCategories()
        }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new category"
            textField = alertTextFeild
        }
        alert .addAction(alertAction)
        present(alert,animated: true,completion: nil)
    }
    //MARK: - Save File
    func saveCategories () {
        do {
            try self.context.save()
        }
        catch {
            print("error Saving \(error)")
        }
        self.tableView.reloadData()
    }
    

    
}
