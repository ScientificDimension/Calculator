//
//  IEnteringCellConfigurator.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IEnteringCellConfigurator {
    func isEnteringCell(index: Int) -> Bool
    func set(enteringCell: CalculatorCell)
    func tryConfigureEnteringCell(transitionDirectionIsForward: Bool)
}
