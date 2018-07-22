//
//  PinningCellCollectionViewLayout.swift
//  Resistance
//
//  Created by Oleg Kolomyitsev on 2/20/17.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case up
    case down
}

class ContainerCellCollectionViewLayout: UICollectionViewFlowLayout {
    
    // MARK: - initial layout configuration
    
    override func prepare() {
        super.prepare()
        configureLayout()
    }
    
    private func configureLayout() {
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = Dimensions().sizeOuter
    }
   
    // MARK: - those methods should be overridden
    
    override class var layoutAttributesClass : AnyClass {
        return ContainerCellAttributes.self
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard
            let cellsInRectOriginal = super.layoutAttributesForElements(in: rect) as? [ContainerCellAttributes],
            let cellsInRectUpdated = copyCells(cellsInRectOriginal),
            let collectionView = collectionView else
        {
            return super.layoutAttributesForElements(in: rect)
        }
        
        updateCustomAttributes(of: cellsInRectUpdated, basedOn: collectionView.bounds.origin)

        return cellsInRectUpdated
    }
    
    // MARK: - custom attributes updating
    
    private func updateCustomAttributes(of cellsInRect: [ContainerCellAttributes], basedOn offset: CGPoint) {
        cellsInRect.forEach { $0.scrollViewContentOffset = offset }
    }
    
}


