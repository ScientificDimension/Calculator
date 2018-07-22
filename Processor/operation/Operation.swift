//
//  Operation.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 04/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class Operation {
    
    // MARK: - Memory Management
    
    var onDidSet: (() -> Void)?
    var onDidClear: (() -> Void)?
    
    init(onDidSet: (() -> Void)? = nil,
         onDidClear: (() -> Void)? = nil) {
        self.onDidSet = onDidSet
        self.onDidClear = onDidClear
    }
    
    // MARK: -
    
    private(set) var text = "" 
    
    // MARK: -
    
    private(set) var type: CalculatorOperation = .empty {
        didSet {
            text = type.text
        }
    }
    
    // MARK: -
    
    func set(_ operation: CalculatorOperation) {
        type = operation
        onDidSet?()
    }
    
    func clear() {
        type = .empty
        onDidClear?()
    }
    
}

