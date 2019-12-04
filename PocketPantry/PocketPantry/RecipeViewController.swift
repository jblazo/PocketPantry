//
//  RecipeViewController.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 11/26/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import UIKit

class RecipeViewController : UIViewController {
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var servingsLabel: UILabel!
    @IBOutlet var readyInLabel: UILabel!
    @IBOutlet var instructionsLabel: UILabel!
    
    
    struct recipie{
        var title : String
        var readyInMinutes : String
        var Servings : Int
        
    }
    
    
    let headers = [
        "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "x-rapidapi-key": "fed8d523cemsh85732f54b32da8fp1815e1jsn8d844d9a2998"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=1&tags=vegetarian%252Cdessert")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
        }
    })
    
    dataTask.resume()
    
    
}


