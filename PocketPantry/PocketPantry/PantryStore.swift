//
//  PantryStore.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

class PantryStore {
    
    static let shared = PantryStore()
    
    let fileName = "PantryData.json"
    
    var items = [PantryItem]()
    
    
    init(){
        loadItems()
    }
    
    func removeItem(_ item: PantryItem){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }
        saveItems()
    }
    
    func addItem(_ item: PantryItem){
        items.append(item)
        saveItems()
    }
    
    func loadItems(){
        let decoder = JSONDecoder()
        do {
            let fileManager = FileManager()
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            self.items = try decoder.decode([PantryItem].self, from: data)
        }
        catch{
            print("Retrieval Error \(error)")
        }
    }
    
    func saveItems(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(items)
            let fileManager = FileManager()
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try data.write(to: fileURL)
        }
        catch{
            print("Save Error \(error)")
        }
        
    }
    
}
