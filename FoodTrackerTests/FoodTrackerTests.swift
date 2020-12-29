//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Boyi Ma on 2020-12-19.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    // MARK: Meal Class Tests
    
    // confirm that the Meal initializer returns a meal object when passed valid parameters
    func testMealInitializationSucceeds() {
        
        // zero rating
        let zeroRatingMeal = Meal.init(name: "zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // highest positive rating
        let positiveRatingMeal = Meal.init(name: "positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    // confirm that the Meal initializer returns nil when passed a negative rating or an empty name
    func testMealInitializationFails() {
        
        // negative rating
        let negativeRatingMeal = Meal.init(name: "negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        // empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }
}
