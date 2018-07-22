//
//  OperandText.swift
//  Calculator
//
//  Created by Oleg Kolomyitsev on 22/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class OperandText: IOperandText {
    
    private enum Digits {
        static let signs = CharacterSet.init(charactersIn: "-")
        static let decimals = CharacterSet.init(charactersIn: ".")
        static let separators = CharacterSet.init(charactersIn: " ")
        static let numbers = CharacterSet.init(charactersIn: "0123456789")
    }
    
    private enum DigitType {
        case integer(_ : String)
        case fraction(_ : String)
        case separator(_ : String)
        case decimal(_ : String)
        case sign(_ : String)
        
        init?(_ digit:Unicode.Scalar, at index:Int, in text:String) {
            
            func hasDecimalBefore(_ index: Int, _ text: String) -> Bool {
                let idx = String.Index(encodedOffset: index)
                let before = String(text[..<idx])
                
                return before.contains(".")
            }
            if Digits.numbers.contains(digit) {
                self = hasDecimalBefore(index, text) ? .fraction(String(digit)) : .integer(String(digit))
            } else if Digits.decimals.contains(digit) {
                self = .decimal(String(digit))
            } else if Digits.separators.contains(digit) {
                self = .separator(String(digit))
            } else if Digits.signs.contains(digit) {
                self = .sign(String(digit))
            } else {
                return nil
            }
        }
    }
    
    private struct DigitTypePattern {
        
        let maximum: Int = 12
        
        let integer: Int
        let fraction: Int
        let separator: Int
        let decimal: Int
        let sign: Int = 1
        
        var total: Int {
            return sign + integer + separator + decimal + fraction
        }
        
        var canAdd: Bool {
            return total < maximum
        }
    }
    
    // MARK: -
    
    private func convert(text: String) -> [DigitType] {
        return text.unicodeScalars.enumerated().compactMap { (index, digit) in
            return DigitType(digit, at: index, in: text)
        }
    }
    
    private func calculate(_ pattern: [DigitType]) -> DigitTypePattern {
        return DigitTypePattern(
            integer: pattern.filter{ if case .integer = $0 { return true } else { return false } }.count,
            fraction: pattern.filter{ if case .fraction = $0 { return true } else { return false } }.count,
            separator: pattern.filter{ if case .separator = $0 { return true } else { return false } }.count,
            decimal: pattern.filter{ if case .decimal = $0 { return true } else { return false } }.count
        )
    }
    
    // MARK: -
    
    private func canAddSign(in text: String) -> Bool {
        return true
    }
    
    private func canAddDecimal(in text: String) -> Bool {
        let pattern = convert(text: text)
        let counts = calculate(pattern)
        
        return ( text.decimalIsLast || !text.hasDecimal ) && counts.canAdd
    }
    
    private func canAddNumber(in text: String) -> Bool {
        let pattern = convert(text: text)
        let counts = calculate(pattern)
        
        return counts.canAdd
    }
    
    // MARK: -
    
    private func allowable(for text: String) -> CharacterSet {
        
        var set = CharacterSet.init(charactersIn: "")
        if canAddSign(in: text) {
            set = set.union(Digits.signs)
        }
        if canAddDecimal(in: text) {
            set = set.union(Digits.decimals)
        }
        if canAddNumber(in: text) {
            set = set.union(Digits.numbers)
        }
        
        return set
    }
    
    private func canAdd(_ digit: String, to text: String) -> Bool {
        let allowableDigits = allowable(for: text)
        return allowableDigits.contains(digit.unicodeScalars.last!)
    }
    
    // MARK: - IOperandText
    
    func add(_ digit: String, to text: String) -> String {
        guard canAdd(digit, to: text) else {
            return text
        }
        if Digits.numbers.contains(digit.unicodeScalars.last!) {
            return text.add(number: digit)
        }
        else if Digits.signs.contains(digit.unicodeScalars.last!) {
            return  text.hasSign ? text.removeSign() : text.addSign()
        }
        else if Digits.decimals.contains(digit.unicodeScalars.last!) {
            guard text.decimalIsLast || !text.hasDecimal else {
                return text
            }
            return text.decimalIsLast ? text.removeDecimal() : text.addDecimal()
        }
        
        return text
    }
}
