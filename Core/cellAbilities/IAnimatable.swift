//
//  IAnimatable.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 14/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IAnimatable {
    func addAnimations()
    func setAnimations(timeOffset: CFTimeInterval)
    func removeAnimations()
}

extension IAnimatable {
    func addAnimations() {}
    func setAnimations(timeOffset: CFTimeInterval) {}
    func removeAnimations() {}
}
