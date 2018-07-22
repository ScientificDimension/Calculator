//
//  CalculationCell.swift
//  022_test_calculatorCell
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculatorCell: UICollectionViewCell, IConfigurable, IAnimatable {
    
    // MARK: - IConfigurable
    
    func configure(_ calculation: Calculation) {
        fatalError("Should be overriden in subclass ")
    }
    
    func configure(_ calculatorState: CalculatorState) {
        fatalError("Should be overriden in subclass ")
    }
    
    // MARK: - IAnimatable
    
    func addAnimations() {
        fatalError("Should be overriden in subclass ")
    }
    
    func setAnimations(timeOffset: CFTimeInterval) {
        fatalError("Should be overriden in subclass ")
    }
    
    func removeAnimations() {
        fatalError("Should be overriden in subclass ")
    }
}


