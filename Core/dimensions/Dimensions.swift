//
//  Dimensions.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 27/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class Dimensions: IDimensions {
    
    // MARK: - IDimensions
    
    let space: CGFloat = 10
    
    let containerOffset: CGFloat = 15
    
    lazy var frameInner: CGRect = {
        return CGRect(x: containerOffset,
                      y: containerOffset,
                      width: sizeContainer.width,
                      height: sizeContainer.height)
    }()
    
    lazy var sizeOuter: CGSize = {
        return CGSize(width: sizeContainer.width + 2 * containerOffset,
                      height: sizeContainer.height + 2 * containerOffset)
    }()

    lazy var sizeContainer:CGSize = {
        return CGSize(width: UIScreen.main.bounds.width - 2 * containerOffset,
                      height: 240 + 40)
    }()
    
    lazy var sizeLabel:CGSize = {
        return CGSize(width:  sizeContainer.width / 2 + containerOffset,
                      height: sizeContainer.height / (6 + 1))
    }()
}
