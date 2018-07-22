//
//  AnimationConfig.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 27/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class AnimationConfig: IAnimationConfig {
    
    // MARK: - Config
    
    let partCount: Int
    
    // MARK: - Memory Management
    
    init(partCount: Int) {
        self.partCount = partCount
    }
    
    init(partCount: Int,
         beginTime: CFTimeInterval) {
        self.partCount = partCount
        self.beginTime = beginTime
    }
    
    convenience init(partCount: Int, interval: Interval) {
        self.init(partCount: partCount)
        self.interval = interval
    }
    
    // MARK: - IAnimationConfig
    
    lazy var keyFrameCount: Int = partCount + 1
    lazy var duration: CFTimeInterval = 1
    lazy var beginTime: CFTimeInterval = 1
    lazy var interval: Interval = .one
    lazy var keyTimes: [NSNumber] = interval.generateSequence(partCount: partCount).map{ NSNumber(value: Float($0)) }
    
    func getTiming(for targetPart: Int) -> AnimationTiming {
        precondition(targetPart >= 1 , "Error: currentPart less than 1")
        precondition(targetPart <= partCount , "Error: currentPart greater than partCount")
        let start = CFTimeInterval(keyTimes[targetPart - 1].doubleValue)
        let finish = CFTimeInterval(keyTimes[targetPart].doubleValue)
        return AnimationTiming(start: start, finish: finish)
    }
}
