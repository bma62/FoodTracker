//
//  Meal.swift
//  FoodTracker
//
//  Created by Boyi Ma on 2020-12-28.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
        
    // MARK: Properties
    
    struct PropertyKey {
        // static vars are attached to the class and shared among instances of the class
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    var name: String
    var photo: UIImage? // meals may not have photos, so this is optional
    var rating: Int
    
    // MARK: Archiving Paths

    // look up the app's documents directory and force unwrap the first match (should contain only 1 match so this is safe)
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals") // create a file URL by appending to documents URL

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
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
    }
    
    // convenience means this is a secondary initializer and it must call a primary initializer from the same class
    required convenience init?(coder: NSCoder) {
        
        // the name is required. if we cannot decode a name string, the initializer should fail
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.")
            return nil
        }
        
        // because photo is an optional property of Meal, just use conditional downcast
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        
        // must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
}

