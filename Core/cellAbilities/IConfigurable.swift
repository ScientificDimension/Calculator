//
//  IConfigurableCell.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 14/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IConfigurable {
    func configure(_ calculation: Calculation)
    func configure(_ calculatorState: CalculatorState)
}

extension IConfigurable {
    func configure(_ calculation: Calculation) {}
    func configure(_ calculatorState: CalculatorState) {}
}
