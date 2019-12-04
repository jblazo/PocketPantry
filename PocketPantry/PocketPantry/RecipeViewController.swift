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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        RecipieAPI.fetchRecipe { (result) in
            switch result{
            case .success(let recipeResponse):
                self.titleLabel.text = recipeResponse.recipes.first?.title
                let servings = recipeResponse.recipes.first?.servings ?? 0
                self.servingsLabel.text = ("\(servings) servings")
                let readyIn = recipeResponse.recipes.first?.readyInMinutes ?? 0
                self.readyInLabel.text = ("Ready in \(readyIn) minutes")
                let instructions = recipeResponse.recipes.first?.instructions ?? "N/A"
                self.instructionsLabel.text = ("Instructions:\n\(instructions)")
            case .failure(let error):
                print("Error = \(error)")
            }
        }
    }
    
    
}


