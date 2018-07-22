//
//  IContentOffesManager.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 04/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IContentOffsetManager
{
    var targetOffset: CGPoint { get }
    
    func trySet(
        _ collectionView: UICollectionView,
        desiredOffset: CGPoint,
        animated: Bool,
        onNoNeedScrolling: ()-> ()
    )
    
    func invalidateTargetOffset(_ newTargetOffset: CGPoint)

}
