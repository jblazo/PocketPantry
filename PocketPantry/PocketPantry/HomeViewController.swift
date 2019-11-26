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
            let adjustedPath = indexPath.row + 1
            
            cell.itemNameLabel.text = store.items[adjustedPath].itemName
            if let date = store.items[adjustedPath].expirationDate {
                cell.expirationDateLabel.text = "\(date)"
            }
            else{
                cell.expirationDateLabel.text = "N/A"
            }
            cell.amountLeftLabel.text = store.items[adjustedPath].amountLeft
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
