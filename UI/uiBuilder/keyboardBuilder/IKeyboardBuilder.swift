//
//  INumpadBuilder.swift
//  022_test_calculatorCell
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit
import CalculatorKeyboard

protocol IKeyboardBuilder {
    
    func buildKeyboard(
        addedTo superview: UIView,
        onKeyPressed: @escaping CalculatorKeyAction,
        onKeyReleased: @escaping CalculatorKeyAction,
        keyTapHandler: @escaping CalculatorKeyAction) -> CalculatorKeyboard

}
