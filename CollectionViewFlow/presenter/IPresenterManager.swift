//
//  IPresenterManager.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IPresenterManager {
    func tryUpdateContainerLabels()
    func invalidateCollectionViewTargetOffset(newTargetOffset: CGPoint)
    func setCollectionView(userInteraction: Bool)
}

