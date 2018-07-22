//
//  ResultText.swift
//  Calculator
//
//  Created by Oleg Kolomyitsev on 22/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ResultText: IResultText {
    
    lazy var digitsCount: Int = 9 /// 9 + 2 = 11 digits without sign
    lazy var decimal = buildDecimal()
    lazy var formatter = buildFormatter()
    
    // MARK: - Memory Management
    
    private func buildFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        
        return formatter
    }
    
    private func buildDecimal() -> Interval {
        let digits = CGFloat(powf(10, Float(digitsCount)))
        return Interval(min: 1 / digits, max: 1 * digits )
    }
    
    // MARK: - IResultText
    
    func getText(from value: CGFloat) -> String {
        let hasSign = value < 0
        let value = fabs(value)
        if decimal.contains(value, include: .none) {
            /// note: without sign
            ///
            /// note: scientific format: 1E3
            ///
            /// length = 11 for 9 integer digits and 2 separators: 999_999_999
            /// or
            /// length = 11 for 1 integer, 1 decimal and 9 fraction digits: 0.000000001
            ///
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = digitsCount
            formatter.maximumIntegerDigits = digitsCount
            let digits = (0...digitsCount)
            let maximumFractions = digits.reversed()
            let thresholds = digits.map { pow(10, CGFloat($0)) }
            for (threshold, maximumFractionDigits) in zip(thresholds, maximumFractions) {
                if value <= threshold {
                    formatter.maximumFractionDigits = maximumFractionDigits
                    break
                }
            }
        } else  {
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 1
            formatter.maximumIntegerDigits = 1
        }
        var text = formatter.string(for: value)!
        if text == "0E0" {
            text = "0"
        }
        if hasSign {
            text = "-" + text
        }
        
        return text
    }
}
