//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Boyi Ma on 2020-12-26.
//

import UIKit

@IBDesignable class RatingControl: UIStackView { // allows IB to have live-copy of this control class
    
    // MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        // after rating is updated, also update the appearance of buttons
        didSet {
            updateButtonSelectionStates()
        }
    }
    
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
        
        // load button images using bundle explicitly so IB can access the images properly
        let bundle = Bundle(for: type(of: self)) // the app's main bundle
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            // create the button
            let button = UIButton()
            
            // set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
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
        
        // after buttons are added to the control, update their states as well
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // if the index of a button is less than rating, that button should be selected
            button.isSelected = index < rating
        }
    }
    
    // MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        // try to find the button in array. if nil is returned, terminate app
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // if the selected star represents the current rating, reset the rating to 0
            rating = 0
        } else {
            // otherwise, set the rating to the selected star
            rating = selectedRating
        }
    }
    

}
