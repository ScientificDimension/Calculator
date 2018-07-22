//
//  CalculationsFeeder.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculationsFeeder: ICalculationsFeeder {
    
    private let calculations: ()->ICalculationStack
    
    // MARK: - Memory Management
    
    init(calculations: @escaping () -> ICalculationStack) {
        self.calculations = calculations
    }
    
    // MARK: - ICalculationsFeeder
    
    var count: Int {
        return calculations().count(softDeleted: .include)
    }
    
    var isEmpty: Bool {
        return calculations().isEmpty
    }
    
    subscript (index: Int) -> Calculation? {
        return calculations()[index]
    }
    
    func removeSoftDeletedCalculations(){
        calculations().removeSoftDeletedCalculations()
    }
}

