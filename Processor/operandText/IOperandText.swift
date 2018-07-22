//
//  IOperandText.swift
//  Calculator
//
//  Created by Oleg Kolomyitsev on 22/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

protocol IOperandText {
    func add(_ digit: String, to text: String) -> String
}

