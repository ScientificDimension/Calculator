//
//  CalculationsCounter.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculationsCounter: ICalculationsCounter {
    
    let calculationsCount: (ContainerShowMode) -> Int
    let removeSoftDeletedCalculations: ()-> Void
    
    init(calculationsCount: @escaping (ContainerShowMode) -> Int,
         removeSoftDeletedCalculations: @escaping ()-> Void) {
        self.calculationsCount = calculationsCount
        self.removeSoftDeletedCalculations = removeSoftDeletedCalculations
    }
}
