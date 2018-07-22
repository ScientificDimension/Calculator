//
//  ContainerView.swift
//  025_test_containerView
//
//  Created by Oleg Kolomyitsev on 15/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculatorContainerView: UIView, IAnimatable, IConfigurable {
    
    // MARK: -
    
    let beginTime: CFTimeInterval = 1

    // MARK: -
    
    lazy var colorSchema: IColorSchema = ColorSchema()
    lazy var animationConfig: IAnimationConfig = AnimationConfig(partCount: 3, beginTime: beginTime)
    lazy var dimensions: IDimensions = Dimensions()
    lazy var component: IComponentFactory = ComponentFactory(dimensions: dimensions)
    
    // MARK: -
    
    lazy var labelOne = component.createLabel(order: 0, color: colorSchema.white, addedTo: self)
    lazy var labelOpr = component.createLabel(order: 1, color: colorSchema.white, addedTo: self)
    lazy var labelTwo = component.createLabel(order: 2, color: colorSchema.white, addedTo: self)
    lazy var labelEql = component.createLabel(order: 3, color: colorSchema.white, addedTo: self)
    lazy var labelRes = component.createLabel(order: 4, color: colorSchema.orange, addedTo: self)
    
    // MARK: - Memory Management
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initial Configurations
    
    private func configure() {
        if Config.highlightElementBorder {
            layer.borderColor = UIColor.yellow.cgColor
            layer.borderWidth = 1
        }
        labelOne.backgroundColor = colorSchema.black
        labelEql.backgroundColor = colorSchema.black
        labelOpr.backgroundColor = colorSchema.black
        labelRes.backgroundColor = colorSchema.black
        labelTwo.backgroundColor = colorSchema.black
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

    // MARK: - IConfigurable
    
    func configure(_ calculation: Calculation) {
        fatalError("Should be overriden in subclass ")
    }
    
    func configure(_ calculatorState: CalculatorState) {
        fatalError("Should be overriden in subclass ")
    }
}
