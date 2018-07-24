//
//  Case5Div1ContainerView.swift
//  025_test_containerView
//
//  Created by Oleg Kolomyitsev on 16/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculationContainerView: CellContainerView {
    
    // MARK: - Memory Management
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IConfigurable

    func configure (_ calculation: Calculation) {
        if !Config.highlightElementBorder {
            labelOne.layer.borderWidth = 0
            labelOpr.layer.borderWidth = 0
            labelTwo.layer.borderWidth = 0
            labelEql.layer.borderWidth = 0
            labelRes.layer.borderWidth = 0
        }
        labelOne.text = calculation.firstOperand.text
        labelOpr.text = calculation.operation.text
        labelTwo.text = calculation.secondOperand.text
        labelEql.text = calculation.result.eqlText
        labelRes.text = calculation.result.resText
    }
}




