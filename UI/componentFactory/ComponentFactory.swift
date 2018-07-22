//
//  ComponentFactory.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 29/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ComponentFactory: IComponentFactory {
    
    class Label: UILabel {
        var rightTextOffset: CGFloat
        override init(frame: CGRect) {
            self.rightTextOffset = 0
            super.init(frame: frame)
        }
        convenience init(frame: CGRect, rightTextOffset: CGFloat) {
            self.init(frame: frame)
            self.rightTextOffset = rightTextOffset
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightTextOffset)
            super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        }
    }
    
    let defaultRightTextOffset: CGFloat = 10
    let dimensions: IDimensions
    
    // MARK: - Memory Management
    
    init(dimensions: IDimensions) {
        self.dimensions = dimensions
    }
    
    // MARK: - IComponentFactory
    
    func label(order: CGFloat, color: UIColor) -> UILabel {
        let frame = CGRect(x: -dimensions.containerOffset,
                           y: (order + 0.5) * dimensions.sizeLabel.height,
                           width:     dimensions.sizeLabel.width,
                           height:    dimensions.sizeLabel.height)
        
        let label = Label(frame:frame, rightTextOffset: defaultRightTextOffset)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = color
        if Config.highlightElementBorder {
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.green.cgColor
        }
        
        return label
    }
}

