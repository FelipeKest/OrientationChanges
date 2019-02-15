//
//  UITopViewBar.swift
//  ARUI_Samples
//
//  Created by Felipe Kestelman on 10/02/19.
//  Copyright © 2019 Felipe Kestelman. All rights reserved.
//

import UIKit

/**
 A custom View for the top of an Experience
 */
class UITopViewBar: UIView {
    
    var dismissButton: UIButton
    var reloadButton: UIButton
    var addedButtonsStackView: UIStackView
    var orientation: ButtonsOrientation
    
    
    /**
     Creates an UIView on top of a screen with the buttons organized
     
     -Parameter buttons: The list of buttons to insert on the bar.
     -Parameter view: The parent view of this bar
     -Parameter orientation: The orientation of the buttons when the device is on landscape
     */
    init(buttons: [UIButton], on view: UIView, orientation: ButtonsOrientation) {
        dismissButton = UIButton(type: .custom)
        reloadButton = UIButton(type: .custom)
        
        addedButtonsStackView = UIStackView()
        self.orientation = orientation
        
        dismissButton.frame = CGRect(x: 0, y: 2, width: 50, height: 50)
        reloadButton.frame = CGRect(x: 0, y: 2, width: 50, height: 50)
        
        //TODO: Substitute these colors with appropriate images
        reloadButton.setImage(UIImage(named: "up-arrow"), for: .normal)
        dismissButton.backgroundColor = .blue
        
        super.init(frame: CGRect(x: 0, y: 24, width: UIScreen.main.bounds.width, height: 49))
        
        /*
         Spacing for horizontal layout
         
         width-2*(button.width+spaceBetweenButtonAndSideOfView) = (numberOfButtons+1)*spacing + 44*numberOfButtons
         spacing = width-2*(button.width+spaceBetweenButtonAndSideOfView)
         */
        
        let spacing = setupStackViewSpacing(numberOfButtons: buttons.count, buttonWidth: 44)
        
        let numberOfButtons = CGFloat(buttons.count)
        
        addedButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        addedButtonsStackView.axis = .horizontal
        
        addedButtonsStackView.frame = CGRect(x: CGFloat(16), y: 2, width: (numberOfButtons+2)*(dismissButton.frame.width)+(numberOfButtons+1)*spacing, height: 44)
        addedButtonsStackView.distribution = .equalSpacing
        addedButtonsStackView.alignment = .center
        addedButtonsStackView.spacing = spacing

        self.backgroundColor = .clear
        
        addedButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addedButtonsStackView.addArrangedSubview(dismissButton)
        for button in buttons {
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            addedButtonsStackView.addArrangedSubview(button)
        }
        addedButtonsStackView.addArrangedSubview(reloadButton)
        
        self.addSubview(addedButtonsStackView)
        
        view.addSubview(self)
        
        setupStackViewPortraitContraints(stackView: addedButtonsStackView)
        setupPortraitConstraints(view: view)
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     Setup constraints for the bar in Portrait Mode
     - Parameter view: The view the will be set up
    */
    func setupPortraitConstraints(view: UIView){
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 49),
            self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
    }
    
    /**
     Determine the spacing for the StackView
     - Parameter numberOfButtons: the ammount of number that will be put up on the view
     - Parameter buttonWidth: the width of all the button which will be set up
     - returns: The spacing of the stack view
    */
    private func setupStackViewSpacing(numberOfButtons:Int,buttonWidth: CGFloat)-> CGFloat{
        var screenSize: CGFloat
        
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            screenSize = UIScreen.main.bounds.height
        } else {
            screenSize = UIScreen.main.bounds.width
        }
        let allButtonsWidth = CGFloat(numberOfButtons)*buttonWidth
        let availableWidth = screenSize - 2*(buttonWidth+16) - allButtonsWidth
        let denominator = CGFloat(numberOfButtons+1)
        return availableWidth/denominator
    }
    
    /**
     Setup constraints for the stack view in the topBar when in portrait mode
     
     */
    private func setupStackViewPortraitContraints(stackView: UIStackView){
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ])
    }
}

/**
 Orientation for the buttons when the device is displayed on landscape
 */
enum ButtonsOrientation {
    case vertical
    case horizontal
}
