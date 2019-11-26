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
    var expirationDate : Date?
    var amountLeft : String?
    
    init(itemName: String) {
        self.itemName = itemName
        self.expirationDate = nil
        self.amountLeft = nil
        
        super.init()
    }
}
