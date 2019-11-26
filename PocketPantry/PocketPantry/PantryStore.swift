//
//  PantryStore.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

class PantryStore {
    
    var items = [PantryItem]()
    
    func removeItem(_ item: PantryItem){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }
        sortItems()
    }
    
    func addItem(_ item: PantryItem){
        items.append(item)
        sortItems()
    }
    
    func sortItems(){
        items.sort { (leftItem, rightItem) -> Bool in
            return leftItem.itemName < rightItem.itemName
        }
    }
}
