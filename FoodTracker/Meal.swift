//
//  Meal.swift
//  FoodTracker
//
//  Created by Boyi Ma on 2020-12-28.
//

import UIKit

class Meal {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage? // meals may not have photos, so this is optional
    var rating: Int

    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // using a series of guards to check parameters before continuing instead of if to improve readability
        
        // the name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // the rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}

