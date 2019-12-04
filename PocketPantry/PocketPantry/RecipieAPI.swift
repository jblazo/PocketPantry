//
//  RecipieAPI.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 12/4/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//


import UIKit
struct RecipeResponse: Codable {
    var recipes: [Recipe]
}


struct Recipe : Codable{
    var title : String
    var readyInMinutes : Int
    var servings : Int
    var instructions : String
    
}
typealias RecipeResponseResult = Swift.Result<RecipeResponse,Error>
typealias RecipeResponseClosure = (RecipeResponseResult) -> Void

class RecipieAPI{
    public class func fetchRecipe(completion: @escaping RecipeResponseClosure){
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
            let result: RecipeResponseResult
            if let error = error {
                result = .failure(error)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let apiResponse = try decoder.decode(RecipeResponse.self, from: data)
                    result = .success(apiResponse)
                } catch {
                    result = .failure(error)
                }
            } else {
                let nsError = NSError(domain: "Recipe", code: -1, userInfo: nil)
                result = .failure(nsError)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        })
        
        dataTask.resume()
    }
}
