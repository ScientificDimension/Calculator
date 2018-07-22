//
//  CalculatorKey+CalculatorEvent.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation
import CalculatorKeyboard

extension CalculatorKey {
    var event: CalculatorEvent {
        switch self {
        case .zero:     return .add(digit: "0")
        case .one:      return .add(digit: "1")
        case .two:      return .add(digit: "2")
        case .three:    return .add(digit: "3")
        case .four:     return .add(digit: "4")
        case .five:     return .add(digit: "5")
        case .six:      return .add(digit: "6")
        case .seven:    return .add(digit: "7")
        case .eight:    return .add(digit: "8")
        case .nine:     return .add(digit: "9")
        case .decimal:  return .add(digit: ".")
        case .sign:     return .add(digit: "-")
        case .clear:    return .clearLast
        case .delete:   return .backspace
        case .multiply: return .addOperation(type: .mul)
        case .divide:   return .addOperation(type: .div)
        case .subtract: return .addOperation(type: .minus)
        case .add:      return .addOperation(type: .plus)
        case .equal:    return .calculateResult
        }
    }
}
