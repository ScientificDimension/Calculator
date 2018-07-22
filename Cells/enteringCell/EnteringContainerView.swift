//
//  WaitingContainerView.swift
//  025_test_containerView
//
//  Created by Oleg Kolomyitsev on 16/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class EnteringContainerView: CalculatorContainerView {
    
    // MARK: - Memory Management
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - initial configurations
    
    private func configure() {
        backgroundColor = colorSchema.black
        labelOne.layer.borderWidth = 1
        labelOpr.layer.borderWidth = 1
        labelTwo.layer.borderWidth = 1
        labelOne.textColor = colorSchema.white
        labelOpr.textColor = colorSchema.white
        labelTwo.textColor = colorSchema.white
    }

    // MARK: - IConfigurable
    
    override func configure (_ calculation: Calculation) {
        labelOne.text = calculation.firstOperand.text
        labelOpr.text = calculation.operation.text
        labelTwo.text = calculation.secondOperand.text
    }
    
    override func configure(_ calculatorState: CalculatorState) {
        switch calculatorState {
        case .enteringFirstOperand:
            labelOne.layer.borderColor = colorSchema.orange.cgColor
            labelOpr.layer.borderColor = colorSchema.black.cgColor
            labelTwo.layer.borderColor = colorSchema.black.cgColor
        case .enteringOperation:
            labelOne.layer.borderColor = colorSchema.black.cgColor
            labelOpr.layer.borderColor = colorSchema.orange.cgColor
            labelTwo.layer.borderColor = colorSchema.black.cgColor
        case .enteringSecondOperand:
            labelOne.layer.borderColor = colorSchema.black.cgColor
            labelOpr.layer.borderColor = colorSchema.black.cgColor
            labelTwo.layer.borderColor = colorSchema.orange.cgColor
        case .completed:
            labelOne.layer.borderColor = colorSchema.black.cgColor
            labelOpr.layer.borderColor = colorSchema.black.cgColor
            labelTwo.layer.borderColor = colorSchema.black.cgColor
        }
    }
    
    // MARK: - IAnimatable
    
    override func setAnimations(timeOffset: CFTimeInterval) {}
    override func removeAnimations() {}
    override func addAnimations() {}
}
