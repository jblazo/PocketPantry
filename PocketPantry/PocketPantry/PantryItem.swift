//
//  PantryItem.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

struct PantryItem : Codable, Equatable{
    var itemName : String
    var expirationDate : String?
    var amountLeft : String?
    
    init(itemName: String) {
        self.itemName = itemName
        self.expirationDate = nil
        self.amountLeft = nil
    }
    
    init(itemName : String, amountLeft : String?) {
        self.itemName = itemName
        self.expirationDate = nil
        self.amountLeft = amountLeft
    }
    
    init(itemName : String, expirationDate : String) {
        self.itemName = itemName
        self.expirationDate = expirationDate
        self.amountLeft = nil
    }
    
    init(itemName : String, expirationDate : String?, amountLeft : String?) {
        self.itemName = itemName
        self.expirationDate = expirationDate
        self.amountLeft = amountLeft
    }
}
