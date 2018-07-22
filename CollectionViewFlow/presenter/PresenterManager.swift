//
//  PresenterManager.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class PresenterManager: IPresenterManager {
    
    private let presenter: ()->ICalculatorPresenter
    
    // MARK: - memoryManagement
    
    init(presenter: @escaping () -> ICalculatorPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - IPresenterManager
    
    func tryUpdateContainerLabels() {
        presenter().tryUpdateContainerLabels()
    }
    
    func invalidateCollectionViewTargetOffset(newTargetOffset: CGPoint) {
        presenter().invalidateCollectionViewTargetOffset(newTargetOffset: newTargetOffset)
    }
    
    func setCollectionView(userInteraction: Bool) {
        presenter().setCollectionView(userInteraction: userInteraction)
    }
}
