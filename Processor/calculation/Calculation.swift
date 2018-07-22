//
//  CalculationBlock.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class Calculation
{
    var onCurrentCalculationDidChanged: ChangeCalculationPositionHandler?
    
    init(onCurrentCalculationDidChanged: ChangeCalculationPositionHandler? = nil) {
        self.onCurrentCalculationDidChanged = onCurrentCalculationDidChanged
    }
    
    // MARK: -
    
    var isDeleted = false
    
    var oneText: String { return firstOperand.text }
    var oprText: String { return operation.text }
    var twoText: String { return secondOperand.text }
    var eqlText: String { return result.eqlText}
    var resText: String { return result.resText }
    
    // MARK: -
    
    lazy var firstOperand = Operand(
        onDidAdd: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringFirstOperand)
        },
        onDidRemove: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringFirstOperand)
    })
    
    lazy var operation = Operation(
        onDidSet: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringOperation)
        },
        onDidClear: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringFirstOperand)
    })
    
    lazy var secondOperand = Operand(
        onDidAdd: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringSecondOperand)
        },
        onDidRemove: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringOperation)
    })
    
    lazy var result = Result(
        onDidPerformCalculation: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.finished)
        },
        onDidClear: { [unowned self] in
            self.onCurrentCalculationDidChanged?(.enteringSecondOperand)
    })

    // MARK: - clear
    
    func clear() {
        firstOperand.clear()
        operation.clear()
        secondOperand.clear()
        result.clear()
        onCurrentCalculationDidChanged?(result.position)
    }

}

