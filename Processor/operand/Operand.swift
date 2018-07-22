//
//  Operand.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 04/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class Operand {
    
    let operandText: IOperandText = OperandText()
    
    // MARK: -
    
    private let maxDigitsLimit = 12 /// numbers or decimal
    
    // MARK: - Memory Management
    
    var onDidAdd: (() -> Void)?
    var onDidRemove: (() -> Void)?
    
    init(onDidAdd: (() -> Void)? = nil,
         onDidRemove: (() -> Void)? = nil) {
        self.onDidAdd = onDidAdd
        self.onDidRemove = onDidRemove
    }
    
    // MARK: -
    
    private(set) var text = "" 
    
    // MARK: -
    
    var value: CGFloat {
        return CGFloat((text.removeAllSeparators() as NSString).doubleValue)
    }

    // MARK: -
    
    var isEmpty: Bool {
        return text.isEmpty
    }
    
    // MARK: -
    
    func removeLastDigit() {
        text = text.removeLastDigit()
        switch text.isEmpty {
        case true: onDidRemove?()
        case false: onDidAdd?()
        }
    }
    
    func add(_ digit: String) {
        text = operandText.add(digit, to: text)
        onDidAdd?()
    }
    
    func setSameAs(_ operand: Operand) {
        text = operand.text
        onDidAdd?()
    }
    
    func setText(_ newText: String) {
        text = newText
    }
    
    func clear() {
        text = ""
    }
}
