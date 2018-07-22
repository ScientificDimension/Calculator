//
//  IComponentFactory.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 29/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IComponentFactory {
    func label(order: CGFloat, color: UIColor) -> UILabel
}

extension IComponentFactory {
    
    func createLabel(order: CGFloat, color: UIColor, addedTo view: UIView) -> UILabel {
        let l = label(order: order, color: color)
        l.addSelf(to: view)
        l.layer.pauseAllAnimations()
        
        return l
    }
}
