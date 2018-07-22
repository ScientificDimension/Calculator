//
//  ReversedCalculationCell.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 10/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculationCell: CalculatorCell {
    
    // MARK: -
    
    private let animationDriver: ICellAnimationDriver = CellAnimationDriver()
    private let dimensions: IDimensions = Dimensions()

    // MARK: - Containers
    
    private lazy var containers: [CalculatorContainerView] = {
        var rollingDominoContainer: CalculatorContainerView = {
            let view = CalculationContainerView(frame: dimensions.frameInner)
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
            contentView.addSubview(view)
            
            return view
        }()
        
        return [
            rollingDominoContainer
        ]
    }()

    // MARK - Memory Management
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initial Configurations

    private func configure() {
        backgroundColor = containers.first?.colorSchema.black
        if Config.highlightElementBorder {
            layer.borderColor = UIColor.blue.cgColor
            layer.borderWidth = 1
        }
    }
    
    // MARK: - IConfigurable
    
    override func configure(_ calculation: Calculation) {
        containers.forEach { $0.configure(calculation)}
    }
    
    override func configure(_ calculatorState: CalculatorState) {}
    
    // MARK: - IAnimatable
    
    override func addAnimations() {
        containers.forEach{ $0.addAnimations() }
    }
    
    override func setAnimations(timeOffset: CFTimeInterval) {
        containers.forEach{ $0.setAnimations(timeOffset: timeOffset) }
    }
    
    override func removeAnimations() {
        containers.forEach{ $0.removeAnimations() }
    }
    
    // MARK: - life cycle
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? ContainerCellAttributes else {
            return
        }
        let alpha = animationDriver.cellContentAlpha(
            cellFrame: attributes.frame,
            scrollViewContentOffset: attributes.scrollViewContentOffset)
        
        containers.forEach { $0.alpha = alpha }
        
        let timeOffset = animationDriver.cellAnimationTimeOffset(
            cellFrame: attributes.frame,
            scrollViewContentOffset: attributes.scrollViewContentOffset)
        
        containers.forEach{ $0.setAnimations(timeOffset: timeOffset) }
    }
}
