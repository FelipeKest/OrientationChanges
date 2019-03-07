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
    
    
    /**
     Creates an UIView on top of a screen with the buttons organized
     
     -Parameter buttons: The list of buttons to insert on the bar.
     -Parameter view: The parent view of this bar
     -Parameter orientation: The orientation of the buttons when the device is on landscape
     */
    init(buttons: [UIButton], on view: UIView) {
        dismissButton = UIButton(type: .custom)
        reloadButton = UIButton(type: .custom)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        addedButtonsStackView = UIStackView()
        
        dismissButton.frame = CGRect(x: 0, y: 2, width: 44, height: 44)
        reloadButton.frame = CGRect(x: 0, y: 2, width: 44, height: 44)
        
        //TODO: Substitute these colors with appropriate images
//        reloadButton.setImage(UIImage(named: "reloadButton"), for: .normal
        reloadButton.backgroundColor = .red
//        dismissButton.setImage(UIImage(named: "backArrow"), for: .normal)
        dismissButton.backgroundColor = .red
        
        super.init(frame: CGRect(x: 0, y: 24, width: UIScreen.main.bounds.width, height: 49))
        
        
        dismissButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        reloadButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        /*
         Spacing for horizontal layout
         
         width-2*(button.width+spaceBetweenButtonAndSideOfView) = (numberOfButtons+1)*spacing + 44*numberOfButtons
         spacing = width-2*(button.width+spaceBetweenButtonAndSideOfView)
         */
        
        let spacing = setupStackViewSpacing(numberOfButtons: buttons.count, buttonWidth: 44)
        
        addedButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        addedButtonsStackView.axis = .horizontal
        
        addedButtonsStackView.frame = CGRect(x: CGFloat(16), y: 2, width: UIScreen.main.bounds.width-32, height: 44)
        addedButtonsStackView.distribution = .equalSpacing
        addedButtonsStackView.alignment = .center
        addedButtonsStackView.spacing = spacing

        self.backgroundColor = .clear
        
        addedButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addedButtonsStackView.addArrangedSubview(dismissButton)
        for button in buttons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            button.widthAnchor.constraint(equalToConstant: 44).isActive = true
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            addedButtonsStackView.addArrangedSubview(button)
        }
        addedButtonsStackView.addArrangedSubview(reloadButton)
        
        
        self.addSubview(addedButtonsStackView)
        
        view.addSubview(self)
        
        setupStackViewContraints(stackView: addedButtonsStackView)
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
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -32)
//            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    /**
     Determine the spacing for the StackView
     - Parameter numberOfButtons: the ammount of number that will be put up on the view
     - Parameter buttonWidth: the width of all the button which will be set up
     - returns: The spacing of the stack view
    */
    private func setupStackViewSpacing(numberOfButtons:Int,buttonWidth: CGFloat)-> CGFloat{
        let screenSize = UIScreen.main.bounds.width
        let availableWidth = screenSize - 32 - CGFloat(numberOfButtons+2)*buttonWidth
        
        let denominator = CGFloat(numberOfButtons+1)
    
        return availableWidth/denominator
    }
    
    /**
     Setup constraints for the stack view in the topBar
     
     - Parameter stackView: the stackView to be set up
     */
    private func setupStackViewContraints(stackView: UIStackView){
        NSLayoutConstraint.activate([
//            stackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -31),
//            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
//            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
//            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
    }
}
