//
//  ListStore.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 12/3/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

class ListStore {
    
    //MARK: - Create the file name for storing data
    let fileName = "ListData.json"
    
    static let shared = ListStore()
    
    init(){
        loadItems()
    }
    
    var items = [ListItem]()
    
    //MARK: - Item Manipulation Funcs
    func removeItem(_ item: ListItem){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }
        saveItems()
    }
    
    func addItem(_ item: ListItem){
        items.append(item)
        saveItems()
    }
    
    
    //MARK: - Create JSON Encoding and Decoding
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
    
    func loadItems(){
        let decoder = JSONDecoder()
        do {
            let fileManager = FileManager()
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            self.items = try decoder.decode([ListItem].self, from: data)
        }
        catch{
            print("Retrieval Error \(error)")
        }
    }
}
