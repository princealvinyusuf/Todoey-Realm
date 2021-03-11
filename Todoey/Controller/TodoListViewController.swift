//
//  ViewController.swift
//  Todoey
//
//  Created by Prince Alvin Yusuf on 02/12/2019.
//  Copyright © 2019 Prince Alvin Yusuf. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
    
    var itemArray: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    // MARK: - Table View Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = itemArray?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added Yet"
        }
        
        return cell
        
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let items = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(items)
                }
            } catch {
                print("Error to update item \(error.localizedDescription)")
            }
            
        }
        
    }
    
    //MARK: - Table View Delegate Method
    //MARK: - Updated / Deleted Data Into Realm Database
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    //  realm.delete(item) // Use this statement to delete item from realm database
                    item.done = !item.done
                }
            } catch {
                print("Error in update data \(error.localizedDescription)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK: - Add Button Pressed
    // MARK: - Ceate A Data Into Realm Database
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen if user click on Add Item button on our Alert
            
            // Action to add data from textfield and save it into realm database
            if let currentCategories = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItems = Item()
                        newItems.title = textField.text!
                        newItems.dateCreated = Date()
                        currentCategories.items.append(newItems)
                    }
                } catch {
                    print("Error saving data into realm database \(error.localizedDescription)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Read Data from Realm Database
    
    func loadItems() {
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    
}

extension TodoListViewController: UISearchBarDelegate {
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
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

