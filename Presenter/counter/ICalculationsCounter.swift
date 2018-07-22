//
//  ICalculationsCounter.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ICalculationsCounter {
    var calculationsCount: (ContainerShowMode) -> Int { get }
    var removeSoftDeletedCalculations: ()-> Void { get }
}
