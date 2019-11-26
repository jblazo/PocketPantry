//
//  Models.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation


struct PantryItem {
    var itemName : String
    var expirationDate : String?
    var amountLeft : String?
}

struct ListItem {
    var itemName : String
    var amountNeeded : String?
}

