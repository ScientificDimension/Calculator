//
//  CalculationStack.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 03/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class CalculationStack: ICalculationStack {
    
    // MARK: - Memory Management
    
    init(onCurrentCalculationDidChanged: ChangeCalculationPositionHandler? = nil) {
        self.onCurrentCalculationDidChanged = onCurrentCalculationDidChanged
    }
    
    // MARK: - ICalculationStack
    
    var onCurrentCalculationDidChanged: ChangeCalculationPositionHandler?
    
    private(set) var stack: [Calculation] = []
    
    subscript(index: Int) -> Calculation? {
        return index < count(softDeleted: .include) ? stack[index] : nil 
    }
    
    func count(softDeleted: SoftDeletedFilter) -> Int {
        switch softDeleted {
        case .include:
            return stack.count
        case .exclude:
            return stack.filter { !$0.isDeleted }.count
        }
    }
    
    func push() {
        addNew()
        onCurrentCalculationDidChanged?(.enteringFirstOperand)
    }
    
    func removeSoftDeletedCalculations() {
        stack = stack.filter { !$0.isDeleted }
    }
    
    func pop() {
        softDeleteLastCalculation()
        onCurrentCalculationDidChanged?(.softDeleted)
    }
    
    var current: Calculation {
        if let last = stack.last {
            return last
        } else {
            return addNew()
        }
    }
    
    var hasMore: Bool {
        return stack.count > 1
    }
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    func reset() {
        stack = []
        onCurrentCalculationDidChanged?(.enteringFirstOperand)
    }
    
    // MARK: -
    
    private func softDeleteLastCalculation() {
        stack.last?.isDeleted = true
    }
    
    @discardableResult
    private func addNew() -> Calculation {
        let last = Calculation(onCurrentCalculationDidChanged: onCurrentCalculationDidChanged)
        stack.append(last)
        
        return last
    }
}
