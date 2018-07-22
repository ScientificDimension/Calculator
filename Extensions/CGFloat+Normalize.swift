//
//  CGFloat+Normalize.swift
//  OEK
//
//  Created by Oleg Kolomyitsev on 3/4/17.
//  Copyright © 2017 Ivankov Alexey. All rights reserved.
//

import Foundation
import UIKit

enum Boundary {
    case both
    case left
    case right
    case none
}

struct Interval {
    
    static var one: Interval { return Interval(min:0, max:1) }
    
    let min:CGFloat
    let max:CGFloat
    
    func contains(_ value: CGFloat, include boundary: Boundary = .both) -> Bool {
        switch boundary {
        case .both:
            return min <= value && value <= max
        case .left:
            return min <= value && value < max
        case .right:
            return min < value && value <= max
        case .none:
            return min < value && value < max
        }
    }
    
    var reversed:Interval {
        return Interval(min:max, max:min)
    }
    
    func generateSequence(partCount: Int) -> [CGFloat] {
        
        func buildArraySource(from: CGFloat, to: CGFloat, numberOfIntervals: Int) -> [CGFloat] {
            /// note that:
            /// arraySource.count == numberOfIntervals + 1
            
            var arraySource: [CGFloat] = []
            
            let by: CGFloat = (to - from) / CGFloat(numberOfIntervals)
            
            for element in stride(from: from, through: to, by: by) {
                arraySource.append(CGFloat(element))
            }
            
            return arraySource
        }

        return buildArraySource(from: min, to: max, numberOfIntervals: partCount)
    }
}

extension CGFloat {
    /*
     * 'normalize' usage example
     *
     *  if
     *
     * 'value' represents contentOffset.y of UIScrollView
     *
     *  and
     *
     * 'normalizedValue' represents alpha of UILabel
     *
     *  then
     *
     *  common usage could looks as follows:
     *
     *
     *        source        target
     *       interval      interval
     *
     *           |             |
     * value2 - 250 ---+      1.5
     *           |     |       |
     *           |     |       |
     *    max - 200    +----> 1.0 - max, normalizedValue2
     *           |             |
     *           |             |
     * value1 - 150 --------> 0.5 - normalizedValue1
     *           |             |
     *           |             |
     *    min - 100           0.0 - min
     *           |             |
     *
     */
    func normalize(from source:Interval, to target:Interval) -> CGFloat {
        var normalizedValue:CGFloat = 0
        if self > source.max {
            normalizedValue = target.max
        } else if self < source.min {
            normalizedValue = target.min
        } else {
            normalizedValue = self.extrapolate(source: source, target: target)
        }
        
        return normalizedValue
    }
    /*
     * 'extrapolate' usage example
     *
     *  if
     *
     * 'value' represents contentOffset.y of UIScrollView
     *
     *  and
     *
     * 'extrapolatedValue' represents alpha of UILabel
     *
     *  then
     *
     * common usage could looks as follows:
     *
     *
     *        source        target
     *       interval      interval
     *
     *           |             |
     * value2 - 250 --------> 1.5 - extrapolatedValue2
     *           |             |
     *           |             |
     *    max - 200           1.0 - max
     *           |             |
     *           |             |
     * value1 - 150 --------> 0.5 - extrapolatedValue1
     *           |             |
     *           |             |
     *    min - 100           0.0 - min
     *           |             |
     *
     */
    func extrapolate(source:Interval, target:Interval) -> CGFloat {
        let divider = (source.min - source.max) / (target.min - target.max)
        let subtrahend = source.min - target.min * divider
        let extrapolatedValue = (self - subtrahend) / divider
        
        return extrapolatedValue
    }
    
    func isIn(_ interval:Interval, include boundary: Boundary = .both) -> Bool {
        switch boundary {
        case .both:
            return interval.min <= self && self <= interval.max
        case .left:
            return interval.min <= self && self < interval.max
        case .right:
            return interval.min < self && self <= interval.max
        case .none:
            return interval.min < self && self < interval.max
        }
    }
}


