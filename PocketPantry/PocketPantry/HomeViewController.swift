//
//  HomeViewController.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{

    var store = PantryStore.shared
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemHomeCell
            let path = indexPath.row
            
            cell.itemNameLabel.text = store.items[path].itemName
            
            if let date = store.items[path].expirationDate {
                cell.expirationDateLabel.text = "\(date)"
                
                if let theAmount = store.items[path].amountLeft{
                    cell.amountLeftLabel.text = theAmount
                }
                else{
                    cell.amountLeftLabel.text = "N/A"
                }
            }
            else{
                cell.expirationDateLabel.text = "N/A"
                
                if let theAmount = store.items[path].amountLeft{
                    cell.amountLeftLabel.text = theAmount
                }
                else{
                    cell.amountLeftLabel.text = "N/A"
                }
            }
            
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexPath = IndexPath(item: 0, section: section)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath) as! ExampleHomeCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let itemtoDelete = store.items[indexPath.row]
            store.removeItem(itemtoDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addNewItem(_ barButtonItem: UIBarButtonItem){
        
        showInputDialog(title: "Add Item",
                        subtitle: "Please enter the new item below.",
                        actionTitle: "Add",
                        cancelTitle: "Cancel",
                        itemNamePlaceholder: "Item Name",
                        expirationPlaceholder: "Expiration Date",
                        amountLeftPlaceholder: "Amount Left",
                        inputKeyboardType: .alphabet)
        { (input:String?, input2:String?, input3:String?) in
            guard input != "" else{
                return
            }
//            guard input != "", input2 != "" else{
//                if let itemName = input {
//                    let addItem = PantryItem(itemName: itemName)
//                    self.store.addItem(addItem)
//                    if let row = self.store.items.firstIndex(of: addItem){
//                        let indexPath = IndexPath(row: row, section: 0)
//                        self.tableView.insertRows(at: [indexPath], with: .automatic)
//                    }
//                }
//                return
//            }
//            guard input != "", input2 != "", input3 != "" else{
//                if let itemName = input, let expirationDate = input2{
//                    let addItem = PantryItem(itemName: itemName, expirationDate: expirationDate)
//                    self.store.addItem(addItem)
//                    if let row = self.store.items.firstIndex(of: addItem){
//                        let indexPath = IndexPath(row: row, section: 0)
//                        self.tableView.insertRows(at: [indexPath], with: .automatic)
//                    }
//                }
//                return
//            }
            
            
            print("The new item is \(input ?? "") expiring \(input3 ?? "")  with \(input2 ?? "") left")
            if let itemName = input, let amountLeft = input3, let expirationDate = input2{
                if amountLeft != "", expirationDate != "" {
                    let addItem = PantryItem(itemName: itemName, expirationDate: expirationDate, amountLeft: amountLeft)
                    PantryStore.shared.addItem(addItem)
                    if let row = PantryStore.shared.items.firstIndex(of: addItem){
                        let indexPath = IndexPath(row: row, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
                else if amountLeft != "", expirationDate == ""{
                    let addItem = PantryItem(itemName: itemName, amountLeft: amountLeft)
                    PantryStore.shared.addItem(addItem)
                    if let row = PantryStore.shared.items.firstIndex(of: addItem){
                        let indexPath = IndexPath(row: row, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
                else if amountLeft == "", expirationDate != ""{
                    let addItem = PantryItem(itemName: itemName, expirationDate: expirationDate)
                    PantryStore.shared.addItem(addItem)
                    if let row = PantryStore.shared.items.firstIndex(of: addItem){
                        let indexPath = IndexPath(row: row, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
                else{
                    let addItem = PantryItem(itemName: itemName)
                    PantryStore.shared.addItem(addItem)
                    if let row = PantryStore.shared.items.firstIndex(of: addItem){
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
}



extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         itemNamePlaceholder:String? = nil,
                         expirationPlaceholder:String? = nil,
                         amountLeftPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?, _ text2: String?, _ text3: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = itemNamePlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = expirationPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = amountLeftPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?[0] else {
                actionHandler?(nil, nil, nil)
                return
            }
            guard let secondTextField = alert.textFields?[1] else{
                actionHandler?(nil, nil, nil)
                return
            }
            guard let thirdTextField = alert.textFields?[2] else{
                actionHandler?(nil, nil, nil)
                return
            }
            actionHandler?(textField.text, secondTextField.text, thirdTextField.text)
            
        }))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
//        let textField = alert.textFields![0] as UITextField
//        let textField2 = alert.textFields![1] as UITextField
        
        self.present(alert, animated: true, completion: nil)
    }
}

