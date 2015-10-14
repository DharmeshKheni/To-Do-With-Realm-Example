//
//  TableViewController.swift
//  Todo
//
//  Created by Anil on 09/10/15.
//  Copyright © 2015 ABBS COMPUTERS. All rights reserved.
//

import UIKit
import CoreData
import Realm

class TableViewController: UITableViewController {
    
    var todos = ToDoItem.allObjects()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todos"
        
    }

    @IBAction func addItem(sender: AnyObject?) {
        let alert = UIAlertController(title: "New item", message: "Add a new item", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save", style: .Default)
            { (action) ->  Void in
                let textField = alert.textFields![0] as UITextField
                let realm = RLMRealm.defaultRealm()
                if textField.text?.characters.count > 0 {
                    let newTodoItem = ToDoItem()
                    newTodoItem.name = textField.text!
                    realm.transactionWithBlock(){
                        realm.addObject(newTodoItem)
                    }
                    self.tableView.reloadData()
                }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        alert.addTextFieldWithConfigurationHandler(nil)
        
        alert.addAction(saveAction)
        
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(todos.count) // [3]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let todo: AnyObject! = todos[UInt(indexPath.row)]
        
        cell.textLabel!.text = todo.name
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // [2]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            deleteRowAtIndexPath(indexPath)
        }
    }
 
    func deleteRowAtIndexPath(indexPath: NSIndexPath)
    {
        let realm = RLMRealm.defaultRealm() //1
        let objectToDelete = todos[UInt(indexPath.row)] as! ToDoItem //2
        realm.beginWriteTransaction() //3
        realm.deleteObject(objectToDelete) //4
        realm.commitWriteTransaction() //5
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) //7
    }

}
