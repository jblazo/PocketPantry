//
//  PantryItem.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

class PantryItem : NSObject {
    var itemName : String
    var expirationDate : String?
    var amountLeft : String?
    
    init(itemName: String) {
        self.itemName = itemName
        self.expirationDate = nil
        self.amountLeft = nil
        
        super.init()
    }
    
    init(itemName : String, amountLeft : String?) {
        self.itemName = itemName
        self.expirationDate = nil
        self.amountLeft = amountLeft
        
        super.init()
    }
    
    init(itemName : String, expirationDate : String?, amountLeft : String?) {
        self.itemName = itemName
        self.expirationDate = expirationDate
        self.amountLeft = amountLeft
        
        super.init()
    }
}
