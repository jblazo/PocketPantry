//
//  ListViewController.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController {
    
    // MARK: - Pantry Store Access
    var pantryStore = PantryStore.shared
    var listStore = ListStore.shared
    
    //MARK: - TableView Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStore.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let path = indexPath.row
        
        cell.itemNameLabel.text = listStore.items[path].itemName
        if let amount = listStore.items[path].amountNeeded, amount != ""{
            cell.amountNeededLabel.text = amount
        }
        else {
            cell.amountNeededLabel.text = "N/A"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexPath = IndexPath(item: 0, section: section)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.backgroundColor = .lightGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let itemtoDelete = listStore.items[indexPath.row]
            listStore.removeItem(itemtoDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK: - Item Editing Funcs
    @IBAction func addNewItem(_ barButtonItem: UIBarButtonItem){
        
        showInputDialog(title: "Add Item",
                        subtitle: "Please enter the new item below.",
                        actionTitle: "Add",
                        cancelTitle: "Cancel",
                        itemNamePlaceholder: "Item Name",
                        amountNeededPlaceholder: "Amount Needed",
                        inputKeyboardType: .alphabet)
        { (input:String?, input2:String?) in
            guard input != "" else{
                return
            }
            if let itemName = input, let amountNeeded = input2 {
                if amountNeeded != ""{
                    let addItem = ListItem(itemName: itemName, amountNeeded: amountNeeded)
                    ListStore.shared.addItem(addItem)
                    if let row = ListStore.shared.items.firstIndex(of: addItem){
                        let indexPath = IndexPath(row: row, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
                
                else{
                    let addItem = ListItem(itemName: itemName)
                    ListStore.shared.addItem(addItem)
                    if let row = ListStore.shared.items.firstIndex(of: addItem){
                        let indexPath = IndexPath(row: row, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
    }
    
    @IBAction func removeItem(_ barButtonItem: UIButton){
        if isEditing {
            barButtonItem.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else{
            barButtonItem.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }

    @IBAction func clearList(_ button : UIButton){
        
    }
    
}

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         itemNamePlaceholder:String? = nil,
                         amountNeededPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?, _ text2: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = itemNamePlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = amountNeededPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?[0] else {
                actionHandler?(nil, nil)
                return
            }
            guard let secondTextField = alert.textFields?[1] else{
                actionHandler?(nil, nil)
                return
            }
            actionHandler?(textField.text, secondTextField.text)
            
        }))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        //        let textField = alert.textFields![0] as UITextField
        //        let textField2 = alert.textFields![1] as UITextField
        
        self.present(alert, animated: true, completion: nil)
    }
}
