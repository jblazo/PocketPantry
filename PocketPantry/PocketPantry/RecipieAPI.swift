//
//  RecipieAPI.swift
//  PocketPantry
//
//  Created by Blazo, Jarod N on 12/4/19.
//  Copyright © 2019 Blazo, Jarod N. All rights reserved.
//

import Foundation

struct recipie : Decodable{
    var title : String
    var readyInMinutes : String
    var Servings : Int
    
}

typealias RecipieResult = Swift.Result<recipie, Error>
typealias RecipieResultClosure = (RecipieResult) -> Void

func fetchRecipie(completion: @escaping RecipieResultClosure){
    var result : RecipieResult
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
    
    //This would be the API Call
    
    
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//        if (error != nil), let theError = error {
//            print(theError)
//        }
//        else if let myData = data{
//            let decoder = JSONDecoder()
//            do {
//                let apiResponse = try decoder.decode(recipie.self, from: myData)
//                result = RecipieResult.success(apiResponse.self)
//            }
//            catch{
//                return
//            }
//        }
//
//        else {
//            let httpResponse = response as? HTTPURLResponse
//            print("\(httpResponse!)")
//        }
//        DispatchQueue.main.async {
//            completion(result)
//        }
//    })
    
    //dataTask.resume()
}
