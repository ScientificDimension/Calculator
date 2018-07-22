//
//  PinningCellAttributes.swift
//  testImages
//
//  Created by Oleg Kolomyitsev on 7/16/17.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ContainerCellAttributes: UICollectionViewLayoutAttributes {
    
    // MARK: - custom attributes
    
    var scrollViewContentOffset: CGPoint = .zero
    
    // MARK: - those methods should be overridden
    
    override func copy(with zone: NSZone?) -> Any {
        let attr = super.copy(with: zone)
        if let attr = attr as? ContainerCellAttributes {
            attr.scrollViewContentOffset = scrollViewContentOffset
        }
        
        return attr
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let attr = object as? ContainerCellAttributes  else {
            return super.isEqual(object)
        }
        if  scrollViewContentOffset == attr.scrollViewContentOffset {
            return super.isEqual(object)
        } else {
            return false
        }
    }
}
