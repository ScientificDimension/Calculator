//
//  IAnimationConfig.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 27/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IAnimationConfig {
    var partCount: Int { get }
    var keyFrameCount: Int { get }
    var beginTime: CFTimeInterval { get }
    var duration: CFTimeInterval { get }
    var keyTimes: [NSNumber] { get }
    
    func getTiming(for targetPart: Int) -> AnimationTiming
}
