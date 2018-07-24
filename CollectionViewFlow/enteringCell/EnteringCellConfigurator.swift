//
//  EnteringCellConfigurator.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit
import SwiftyStateMachine

class EnteringCellConfigurator: IEnteringCellConfigurator {
    
    typealias IsEnteringCell = (Int) -> Bool
    typealias CalculatorStateMachine = () -> (
        direction: StateMachineTransitionDirection,
        state: CalculatorState)
    
    // MARK: - Enering Cell
    
    private(set) weak var enteringCell: ICalculatorCell? = nil
    
    // MARK: -
    
    let isEnteringCell: IsEnteringCell
    let calculatorStateMachine: CalculatorStateMachine
    
    // MARK: - Memory Management
    
    init(isEnteringCell: @escaping IsEnteringCell,
         calculatorStateMachine: @escaping CalculatorStateMachine) {
        self.isEnteringCell = isEnteringCell
        self.calculatorStateMachine = calculatorStateMachine
    }
    
    // MARK: - IEnteringCellConfigurator
    
    func isEnteringCell(index: Int) -> Bool {
        return isEnteringCell(index)
    }
    
    func set(enteringCell: ICalculatorCell) {
        self.enteringCell = enteringCell
    }
    
    func tryConfigureEnteringCell(transitionDirectionIsForward: Bool) {
        typealias EqualOrNot = (
            _ left: StateMachineTransitionDirection,
            _ right: StateMachineTransitionDirection) -> Bool
        let equalOrNot: EqualOrNot = transitionDirectionIsForward ? (==) : (!=)
        if equalOrNot(calculatorStateMachine().direction, .forward) {
            enteringCell?.configure(calculatorStateMachine().state)
        }
    }
}

