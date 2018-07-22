//
//  CalculatorUIBuilder.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 15/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit
import CalculatorKeyboard

struct CalculatorUIBuilder: ICalculatorUIBuilder {
    
    // MARK: - Memory Management
    
    let dimensions: IDimensions
    
    init(dimensions: IDimensions) {
        self.dimensions = dimensions
    }
    
    // MARK: - ICalculatorUIBuilder
    
    func buildCollectionView(
        addedTo superview: UIView,
        with configure: (UICollectionView) -> ()) -> UICollectionView {
        
        let builder: ICollectionViewBuilder = CollectionViewBuilder(dimensions: dimensions)
        
        return builder.buildCollectionView(addedTo:superview, with: configure)
    }
    
    func buildKeyboard(
        addedTo superview: UIView,
        onKeyPressed: @escaping CalculatorKeyAction,
        onKeyReleased: @escaping CalculatorKeyAction,
        keyTapHandler: @escaping CalculatorKeyAction) -> CalculatorKeyboard {
        
        let builder: IKeyboardBuilder = KeyboardBuilder(dimensions: dimensions)
        
        return builder.buildKeyboard(
            addedTo: superview,
            onKeyPressed: onKeyReleased,
            onKeyReleased: onKeyReleased,
            keyTapHandler: keyTapHandler)
    }
}
