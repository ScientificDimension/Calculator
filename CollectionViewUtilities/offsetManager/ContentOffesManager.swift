//
//  ContentOffesManager.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 04/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ContentOffsetManager: IContentOffsetManager {
    
    private(set) var targetOffset: CGPoint = .zero
    
    // MARK: - IContentOffsetManager
    
    func trySet(
        _ collectionView: UICollectionView,
        desiredOffset: CGPoint,
        animated: Bool,
        onNoNeedScrolling: ()-> ())
    {
        if collectionView.contentOffset == desiredOffset {
            onNoNeedScrolling()
        }
        
        guard desiredOffset != targetOffset else {
            return
        }
        
        targetOffset = desiredOffset
        
        collectionView.setContentOffset(desiredOffset, animated: true)
    }
    
    func invalidateTargetOffset(_ newTargetOffset: CGPoint) {
        targetOffset = newTargetOffset
    }
    
}
