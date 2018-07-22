//
//  CalculatorState.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation
import SwiftyStateMachine

enum CalculatorState: Int, IDirectionDeterminable {
    case enteringFirstOperand = 1
    case enteringOperation = 2
    case enteringSecondOperand = 3
    case completed = 4
    
    func determineDirection (previousState: CalculatorState) -> StateMachineTransitionDirection {
        let currentState = self
        
        let diff = currentState.rawValue - previousState.rawValue
        
        return diff > 0 ? .forward : diff < 0 ? .back : .idle
    }
}
