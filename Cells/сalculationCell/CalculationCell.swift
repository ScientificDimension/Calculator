//
//  ReversedCalculationCell.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 10/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculationCell: UICollectionViewCell, ICalculatorCell {
    
    // MARK: -
    
    private let animationDriver: ICellAnimationDriver = CellAnimationDriver()
    private let dimensions: IDimensions = Dimensions()

    // MARK: - Containers
    
    private lazy var container: CalculationContainerView = {
        let view = CalculationContainerView(frame: dimensions.frameInner)
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        contentView.addSubview(view)
        
        return view
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
        backgroundColor = container.colorSchema.black
        if Config.highlightElementBorder {
            layer.borderColor = UIColor.blue.cgColor
            layer.borderWidth = 1
        }
    }
    
    // MARK: - IConfigurable
    
    func configure(_ calculation: Calculation) {
        container.configure(calculation)
    }
    
    func configure(_ calculatorState: CalculatorState) {}
    
    // MARK: - IAnimatable
    
    func addAnimations() {
        container.addAnimations()
    }
    
    func setAnimations(timeOffset: CFTimeInterval) {
        container.setAnimations(timeOffset: timeOffset)
    }
    
    func removeAnimations() {
        container.removeAnimations()
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
        
        container.alpha = alpha
        
        let timeOffset = animationDriver.cellAnimationTimeOffset(
            cellFrame: attributes.frame,
            scrollViewContentOffset: attributes.scrollViewContentOffset)
        
        container.setAnimations(timeOffset: timeOffset)
    }
}
