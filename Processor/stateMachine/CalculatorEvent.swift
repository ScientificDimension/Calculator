//
//  CalculatorEvent.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

enum CalculatorEvent {
    case add(digit: String)
    case addOperation(type: CalculatorOperation)
    case backspace
    case clearLast
    case clearAll
    case calculateResult
}



