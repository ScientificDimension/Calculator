//
//  ICellAnimationDriver.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 12/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ICellAnimationDriver {
    
    func cellAnimationTimeOffset(cellFrame: CGRect, scrollViewContentOffset: CGPoint) -> CFTimeInterval
    
    func cellContentAlpha(cellFrame: CGRect, scrollViewContentOffset: CGPoint) -> CGFloat
    
}
