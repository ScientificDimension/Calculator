//
//  Result.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 04/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class Result {
    
    let resultText: IResultText = ResultText()
    
    // MARK: - Memory Management
    
    var onDidPerformCalculation: (() -> Void)?
    var onDidClear: (() -> Void)?
    
    init(onDidPerformCalculation: (() -> Void)? = nil,
         onDidClear: (() -> Void)? = nil) {
        self.onDidPerformCalculation = onDidPerformCalculation
        self.onDidClear = onDidClear
    }
    
    // MARK: -
    
    private(set) var eqlText = ""
    private(set) var resText = ""
    
    // MARK: -
    
    private(set) var calculated: Bool = false {
        didSet {
            if calculated {
                eqlText = "="
                resText = resultText.getText(from: value)
            } else {
                eqlText = ""
                resText = ""
            }
        }
    }
    
    var position: CalculationPosition {
        return calculated ? .finished : .enteringFirstOperand
    }
    
    // MARK: -
    
    private(set) var value: CGFloat = 0
    
    // MARK: -
    
    func canPerformCalculation(
        firstOperand: Operand,
        operation: Operation,
        secondOperand: Operand) -> Bool{
        let can =
            !firstOperand.text.isEmpty &&
            !operation.text.isEmpty &&
            !secondOperand.text.isEmpty
        
        return can
    }
    
    func tryPerformCalculation(
        firstOperand: Operand,
        operation: Operation,
        secondOperand: Operand)
    {
        switch operation.type {
        case .div: value = firstOperand.value / secondOperand.value
        case .mul: value = firstOperand.value * secondOperand.value
        case .plus: value = firstOperand.value + secondOperand.value
        case .minus: value = firstOperand.value - secondOperand.value
        case .empty: value = firstOperand.value / secondOperand.value
        }
        calculated = true
        onDidPerformCalculation?()
    }
    
    func clear() {
        calculated = false
        onDidClear?()
    }

}
