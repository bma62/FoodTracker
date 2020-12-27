//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Boyi Ma on 2020-12-26.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0
    
    // properties that can be changed in the IB and refresh the control every time these properties change
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        // property observer
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: Initialization
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Private Methods
    
    private func setupButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button) // tell the stack view to stop arranging for the button
            button.removeFromSuperview() // remove button from stack view entirely
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            // create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            // add constraints
            button.translatesAutoresizingMaskIntoConstraints = false // disable automatically generated constraints for programmatically created views
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true // constraint height and width, and activate them
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // add the button to the stack
            addArrangedSubview(button)
            
            // add the new button to the rating button array
            ratingButtons.append(button)
        }
    }
    
    // MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }

}
