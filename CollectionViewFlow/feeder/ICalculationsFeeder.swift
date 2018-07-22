//
//  ICalculationsFeeder.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ICalculationsFeeder {
    var count: Int { get }
    var isEmpty: Bool { get }
    subscript (index: Int) -> Calculation? { get }
    func removeSoftDeletedCalculations()
}
