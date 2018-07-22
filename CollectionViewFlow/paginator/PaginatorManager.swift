//
//  PaginatorManager.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class PaginatorManager: IPaginatorManager {
    
    // MARK: - IPaginatorManager
    
    let updateCellCount: () -> Void
    let centeredContentOffset: (_ proposedContentOffset: CGPoint) -> CGPoint
    
    // MARK: - Memory Management
    
    init(updateCellCount: @escaping () -> Void,
        centeredContentOffset: @escaping (_ proposedContentOffset: CGPoint) -> CGPoint) {
        self.updateCellCount = updateCellCount
        self.centeredContentOffset = centeredContentOffset
    }
}
