//
//  HomeViewController.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import UIKit

class HomeViewController : UITableViewController{

    var store : [PantryItem] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath) as! ExampleHomeCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemHomeCell
            let adjustedPath = indexPath.row + 1
            
            cell.itemNameLabel.text = store[adjustedPath].itemName
            cell.expirationDateLabel.text = store[adjustedPath].expirationDate
            cell.amountLeftLabel.text = store[adjustedPath].amountLeft
            return cell
        }
        
    }
}
