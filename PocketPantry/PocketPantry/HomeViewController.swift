//
//  HomeViewController.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{

    var store = PantryStore()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.items.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath) as! ExampleHomeCell
            return cell
        }
        else{
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
        
    }
    
    @IBAction func addNewItem(_ barButtonItem: UIBarButtonItem){
        let itemtoAdd = PantryItem(itemName: "Milk")
        store.addItem(itemtoAdd)
        //Do not assume it got added to the end of the array
        if let row = store.items.firstIndex(of: itemtoAdd){
            let indexPath = IndexPath(row: row, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}
