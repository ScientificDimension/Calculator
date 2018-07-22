//
//  CalculatorSchema.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation
import SwiftyStateMachine

typealias CalculatorStateMachineSchema = StateMachineSchema<CalculatorState, CalculatorEvent, ICalculationStack>

class CalculatorSchema {
    
    static var schema = CalculatorStateMachineSchema(initialState: .enteringFirstOperand) { (currentState, event) in
        
        func stateIndependentEventsHandling(_ currentState: CalculatorState, _ event: CalculatorEvent) -> ((ICalculationStack) -> CalculatorState)? {
            if case .clearAll = event {
                return { calculations in
                    calculations.reset()
                    return .enteringFirstOperand
                }
            }
            if case .clearLast = event {
                return { calculations in
                    if  calculations.hasMore {
                        calculations.pop()
                        return .completed
                    }
                    calculations.reset()
                    return .enteringFirstOperand
                }
            }
            return nil
        }
        
        func toSameStateEventsHandling(_ currentState: CalculatorState, _ event: CalculatorEvent) -> ((ICalculationStack) -> CalculatorState)? {
            if case .calculateResult = event, [.enteringOperation, .enteringSecondOperand, .completed].contains(currentState) {
                return { calculations in
                    switch currentState {
                    case .enteringOperation:
                        calculations.current.secondOperand.setSameAs(calculations.current.firstOperand)
                    case .completed:
                        let result = calculations.current.result.resText
                        let operation = calculations.current.operation.type
                        let second = calculations.current.secondOperand.text
                        calculations.push()
                        calculations.current.firstOperand.setText(result)
                        calculations.current.operation.set(operation)
                        calculations.current.secondOperand.setText(second)
                    default:
                        break
                    }
                    calculations.current.result.tryPerformCalculation(
                        firstOperand: calculations.current.firstOperand,
                        operation: calculations.current.operation,
                        secondOperand: calculations.current.secondOperand)
                    return .completed
                }
            }
            
            if case let .addOperation(type) = event, [.enteringFirstOperand, .enteringOperation, .enteringSecondOperand, .completed].contains(currentState) {
                return { calculations in
                    switch currentState {
                    case .enteringSecondOperand:
                        calculations.current.result.tryPerformCalculation(
                            firstOperand: calculations.current.firstOperand,
                            operation: calculations.current.operation,
                            secondOperand: calculations.current.secondOperand)
                        let result = calculations.current.result.resText
                        calculations.push()
                        calculations.current.firstOperand.setText(result)
                    case .completed:
                        let result = calculations.current.result.resText
                        calculations.push()
                        calculations.current.firstOperand.setText(result)
                    default:
                        break
                    }
                    if !calculations.current.firstOperand.isEmpty {
                        calculations.current.operation.set(type)
                        return .enteringOperation
                    }
                    return .enteringFirstOperand
                }
            }
            return nil
        }
        
        func stateDependentEventsHandling(_ currentState: CalculatorState, _ event: CalculatorEvent) -> ((ICalculationStack) -> CalculatorState)? {
            switch currentState {
            case .enteringFirstOperand:
                switch event {
                case let .add(digit):
                    return { calculations in
                        calculations.current.firstOperand.add(digit)
                        return .enteringFirstOperand
                    }
                case .backspace:
                    return { calculations in
                        if !calculations.current.firstOperand.isEmpty {
                            calculations.current.firstOperand.removeLastDigit()
                        }
                        if calculations.current.firstOperand.isEmpty && calculations.hasMore {
                            calculations.pop()
                            return .completed
                        }
                        return .enteringFirstOperand
                    }
                default:
                    return nil
                }
                
            case .enteringOperation:
                switch event {
                case let .add(digit):
                    return  { calculations in
                        calculations.current.secondOperand.add(digit)
                        return .enteringSecondOperand
                    }
                case .backspace:
                    return { calculations in
                        calculations.current.operation.clear()
                        return .enteringFirstOperand
                    }
                default:
                    return nil
                }
                
            case .enteringSecondOperand:
                switch event {
                case let .add(digit):
                    return { calculations in
                        calculations.current.secondOperand.add(digit)
                        return .enteringSecondOperand
                    }
                case .backspace:
                    return { calculations in
                        calculations.current.secondOperand.removeLastDigit()
                        return calculations.current.secondOperand.isEmpty ? .enteringOperation : .enteringSecondOperand
                    }
                default:
                    return nil
                }
            case .completed:
                switch event {
                case let .add(digit):
                    return  { calculations in
                        calculations.push()
                        calculations.current.firstOperand.add(digit)
                        return .enteringFirstOperand
                    }
                case .backspace:
                    return { calculations in
                        calculations.current.result.clear()
                        return .enteringSecondOperand
                    }
                default:
                    return nil
                }
            }
        }

        let nextState =
            stateIndependentEventsHandling(currentState, event) ??
            toSameStateEventsHandling(currentState, event) ??
            stateDependentEventsHandling(currentState, event) ?? nil
        
        return nextState
        
    }
}
