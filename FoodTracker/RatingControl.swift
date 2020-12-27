//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Boyi Ma on 2020-12-26.
//

import UIKit

class RatingControl: UIStackView {
    
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
        
        // create the button
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        // add constraints
        button.translatesAutoresizingMaskIntoConstraints = false // disable automatically generated constraints for programmatically created views
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true // constraint height and width, and activate them
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        // setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        // add the button to the stack
        addArrangedSubview(button)
    }
    
    // MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }

}
