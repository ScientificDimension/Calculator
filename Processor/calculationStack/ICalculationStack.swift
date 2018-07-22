//
//  ICalculationStack.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 03/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

enum SoftDeletedFilter {
    case include
    case exclude
}

typealias ChangeCalculationPositionHandler = (CalculationPosition) -> Void

protocol ICalculationStack {
    
    var onCurrentCalculationDidChanged: ChangeCalculationPositionHandler? { get set }

    func count(softDeleted: SoftDeletedFilter) -> Int
    
    subscript(index: Int) -> Calculation? { get }
    
    func push()
    func pop()
    
    var current: Calculation { get }
    
    var hasMore: Bool { get }
    var isEmpty: Bool { get }
    
    func removeSoftDeletedCalculations()
    
    func reset()

}
