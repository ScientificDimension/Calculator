//
//  CellAnimationDriver.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 12/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CellAnimationDriver: ICellAnimationDriver
{
    func cellAnimationTimeOffset(cellFrame: CGRect, scrollViewContentOffset: CGPoint) -> CFTimeInterval
    {
        let y = cellFrame.origin.y
        let half = cellFrame.height / 2
        let offset = Interval(min: y - half, max: y)
        let time = Interval.one
        let timeOffset = scrollViewContentOffset.y.normalize(from: offset, to: time)
        
        return CFTimeInterval(timeOffset)
    }
    
    func cellContentAlpha(cellFrame: CGRect, scrollViewContentOffset: CGPoint) -> CGFloat
    {
        let y = cellFrame.origin.y
        let half = cellFrame.height / 2
        let offset = Interval(min: y, max: y + half)
        let alpha = Interval.one.reversed
        let contentAlpha = scrollViewContentOffset.y.normalize(from: offset, to: alpha)
        
        return contentAlpha
    }
}
