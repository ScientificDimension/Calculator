//: Playground - noun: a place where people can play

import UIKit

let cellCount: Int = 4
let cellHeight: CGFloat = 90

enum Summand {
    case oneThirds
    case twoThirds
    
    var value: CGFloat {
        switch self {
        case .oneThirds: return 1/3
        case .twoThirds: return 2/3
        }
    }
    
    mutating func next() {
        switch self {
        case .oneThirds: self = .twoThirds
        case .twoThirds: self = .oneThirds
        }

    }
}
/// centered offset multipliers

var summand: Summand = .oneThirds
var centers: [CGFloat] = [-summand.value]

for index in 1..<(2 * cellCount) {
    centers.append(centers[index - 1] + summand.value)
    summand.next()
}

centers

/// centered offsets

let offset = centers.map { $0 * cellHeight}
offset

/// margin multipliers

var margins: [CGFloat] = []
summand = .oneThirds
for index in 0..<(2 * cellCount - 1) {
    margins.append(centers[index] + summand.value / 2)
    summand.next()
}

/// margins

let absoluteMargins = margins.map { $0 * cellHeight }

absoluteMargins

/// intervals

struct Interval
{
    static var one: Interval { return Interval(min:0, max:1) }
    
    let min:CGFloat
    let max:CGFloat
    
    func contains(_ value:CGFloat) -> Bool {
        return min <= value && value <= max
    }
    
    var reversed:Interval {
        return Interval(min:max, max:min)
    }
}

let intervalFirst = Interval(min: CGFloat.leastNormalMagnitude, max: absoluteMargins[0])
var intervals: [Interval] = [intervalFirst]

for index in 1..<(2 * cellCount - 1) {
    let interval = Interval(min: absoluteMargins[index - 1], max: absoluteMargins[index])
    intervals.append(interval)
}

let intervalLast = Interval(min: absoluteMargins[2 * cellCount - 2], max: CGFloat.greatestFiniteMagnitude)
intervals.append(intervalLast)

for interval in intervals {
    print(interval)
}




