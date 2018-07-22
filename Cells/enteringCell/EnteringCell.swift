//
//  WaitingCalculationCell.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 14/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class EnteringCell: CalculatorCell {
    
    // MARK: -
    
    private lazy var dimensions: IDimensions = Dimensions()
    private lazy var container: CalculatorContainerView = {
        let view = EnteringContainerView(frame: dimensions.frameInner)
        contentView.addSubview(view)
        
        return view
    }()
    
    // MARK - memory management
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - initial config
    
    private func configure() {
        backgroundColor = container.colorSchema.black
    }
    
    // MARK: - IConfigurable
    
    override func configure(_ calculation: Calculation) {
        container.configure(calculation)
    }
    
    override func configure(_ calculatorState: CalculatorState) {
        container.configure(calculatorState)
    }
    
    // MARK: - IAnimatable
    
    override func addAnimations() {}
    override func setAnimations(timeOffset: CFTimeInterval) {}
    override func removeAnimations() {}
}
