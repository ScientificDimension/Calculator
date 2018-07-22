//
//  AnimationTiming.swift
//  030_replicatorLayer
//
//  Created by Oleg Kolomyitsev on 18/02/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

struct AnimationTiming {
    
    static let empty = AnimationTiming(start: 0, finish: 0)
    
    let start: CFTimeInterval
    let finish: CFTimeInterval
    
    var duration: CFTimeInterval {
        return abs(finish - start)
    }
    
    var interval: Interval {
        return Interval(min: CGFloat(start), max: CGFloat(finish))
    }
}
