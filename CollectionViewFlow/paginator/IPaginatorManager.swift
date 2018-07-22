//
//  IPaginatorManager.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 06/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IPaginatorManager {
    var updateCellCount: ()->Void { get }
    var centeredContentOffset: (_ proposedContentOffset: CGPoint) -> CGPoint { get }
}

