//
//  CalculatorOperation.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

enum CalculatorOperation {
    case div
    case mul
    case plus
    case minus
    case empty
    
    var text: String {
        switch self {
        case .div: return "÷"
        case .mul: return "×"
        case .plus: return "+"
        case .minus: return "−"
        case .empty: return ""
        }
    }
    
    var cellId: String {
        switch self {
        case .div: return "\(CalculationCell.self)"
        case .mul: return "\(CalculationCell.self)"
        case .plus: return "\(CalculationCell.self)"
        case .minus: return "\(CalculationCell.self)"
        case .empty: return "\(EnteringCell.self)"
        }
    }
}


