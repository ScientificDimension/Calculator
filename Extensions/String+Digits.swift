//
//  String+Digits.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 20/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation


extension String {
    
    // MARK: - Removing
    
    func removeLastDigit() -> String {
        guard self != "0." else {
            return ""
        }
        guard self != "-0." else {
            return "-"
        }
        var text = String(dropLast())
        guard !self.hasDecimal else {
            return text
        }
        text = updateSeparators(text)

        return text
    }
    
    func removeFistDigit() -> String {
        guard self.count > 1 else {
            return ""
        }

        return String(dropFirst())
    }
    
    // MARK: - Decimal
    
    var hasDecimal: Bool {
        return range(of:".") != nil
    }
    
    var decimalIsLast: Bool {
        return hasSuffix(".")
    }
    
    func addDecimal() -> String {
        guard !hasDecimal else {
            return self
        }
        guard self != "" && self != "-" else {
            return self + "0."
        }
        
        return self + "."
    }
    
    func removeDecimal() -> String {
        guard decimalIsLast else {
            return self
        }
        
        return removeLastDigit()
    }
    
    // MARK: - Sign
    
    var hasSign: Bool {
        return hasPrefix("-")
    }
    
    func addSign() -> String {
        guard !hasSign else {
            return self
        }
        
        return "-" + self
    }
    
    func removeSign() -> String {
        guard hasSign else {
            return self
        }
        
        return removeFistDigit()
    }
    
    // MARK: - Number
    
    func add(number: String) -> String {
        guard self != "0" && self != "-0" else {
            return self
        }
        var text = self + number
        guard !text.hasDecimal else {
            return text
        }
        text = updateSeparators(text)
        
        return text
    }
    
    // MARK: - Separators
    
    private func updateSeparators(_ text: String) -> String
    {
        var text = text
        let storedSign = text.hasSign
        text = text.removeSign().removeAllSeparators().addSeparators()
        if storedSign {
            text = text.addSign()
        }

        return text
    }
    
    func removeAllSeparators() -> String {
        return split(separator: " ").joined()
    }
    
    private func addSeparators() -> String {
        var textWithSeparators = ""
        var count = 0
        for (index, digit) in enumerated().reversed() {
            textWithSeparators = String(digit) + textWithSeparators
            count += 1
            if count == 3 && index != 0 {
                textWithSeparators = " " + textWithSeparators
                count = 0
            }
        }
        
        return textWithSeparators
    }
}

