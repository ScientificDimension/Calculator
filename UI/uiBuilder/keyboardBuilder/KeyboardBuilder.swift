//
//  NumpadBuilder.swift
//  022_test_calculatorCell
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit
import CalculatorKeyboard

class KeyboardBuilder: IKeyboardBuilder { 
    
    // MARK: - Memory Management
    
    let dimensions: IDimensions
    let topProvider: ITopProvider

    init(dimensions: IDimensions,
         navigationController: UINavigationController? = nil) {
        self.dimensions = dimensions
        self.topProvider = TopProvider(
            dimensions: dimensions,
            navigationController: navigationController)
    }
    
    // MARK: - ICollectionViewBuilder
    
    func buildKeyboard(
        addedTo superview: UIView,
        onKeyPressed: @escaping CalculatorKeyAction,
        onKeyReleased: @escaping CalculatorKeyAction,
        keyTapHandler: @escaping CalculatorKeyAction) -> CalculatorKeyboard {
        let keyboard = CalculatorKeyboard(frame: .zero)
        add(keyboard, to: superview)
        keyboard.onKeyPressed = onKeyPressed
        keyboard.onKeyReleased = onKeyReleased
        keyboard.keyTapHandler = keyTapHandler
        
        return keyboard
    }

    // MARK: -
    
    private func add(_ keyboard: CalculatorKeyboard, to superview: UIView) {
        superview.addSubview(keyboard)
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        keyboard.topAnchor.constraint(equalTo: superview.topAnchor, constant: topProvider.top + dimensions.sizeOuter.height + dimensions.space).isActive = true
        keyboard.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        keyboard.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        keyboard.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -0).isActive = true
        if Config.highlightElementBorder {
            keyboard.layer.borderWidth = 1
            keyboard.layer.borderColor = UIColor.cyan.cgColor
        }
    }
}
