//
//  ListItem.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 12/3/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

struct ListItem : Codable, Equatable{
    var itemName : String
    var amountNeeded : String?
    
    init(itemName : String){
        self.itemName = itemName
        self.amountNeeded = nil
    }
    
    init(itemName : String, amountNeeded : String){
        self.itemName = itemName
        self.amountNeeded = amountNeeded
    }
    
}
