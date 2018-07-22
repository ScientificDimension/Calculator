//
//  AutocenteredCalculator.swift
//  Resistance
//
//  Created by Oleg Kolomyitsev on 2/20/17.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

/*                  Centered Paging
 *
 *   +------------------------+--+-+
 *   |                        |  | | halfContainerHeight
 *   |                        |  | |
 *   |<----firstCellCenter--->|--|-+
 *   |                        |  |
 *   |                        |  |
 *   +------------------------+  | contentSize.height
 *   |                        |  |
 *   |                        |  |
 *   |<----nextCellCenter---->|  |
 *   |                        |  |
 *   |                        |  |
 *   +------------------------+--+
 *
 */

typealias CenteringPaginatorConfig = (
    cellCount:Int,
    cellHeight:CGFloat
)

protocol ICenteringPaginator
{
    func centeringContentOffset(for proposedContentOffset: CGPoint) -> CGPoint
    func page(for contentOffset: CGPoint) -> Int
    func update(newCellCount: Int)
}

class CenteringPaginator: ICenteringPaginator
{
    let centering: CGFloat = 1

    // MARK: - memory management
    
    private var cellCount: Int
    private let cellHeight: CGFloat

    init(with config:CenteringPaginatorConfig) {
        cellCount = config.cellCount
        cellHeight = config.cellHeight
    }
    
    // MARK: - paging
    
    private var cellCenters: [CGFloat] {
        return yCellCenters(
            cellCount: cellCount,
            cellHeight: cellHeight
        )
    }
    
    // MARK: - should be used in scrollView delegate methods
    
    func update(newCellCount: Int) {
        cellCount = newCellCount
    }
    
    func centeringContentOffset(for proposedContentOffset: CGPoint) -> CGPoint {
        var centeredContentOffset = proposedContentOffset
        guard cellCount > 0 else {
            return centeredContentOffset
        }
        for (index, interval) in yIntervals(cellCount, cellHeight).enumerated() {
            if interval.contains(proposedContentOffset.y) {
                centeredContentOffset.y = centerMultipliers(cellCount).map { $0 * cellHeight } [index]
                break
            }
        }
        
        return centeredContentOffset
    }
    
    private func centerMultipliers(_ cellCount:Int) -> [CGFloat] {
        var centers: [CGFloat] = [-centering]
        for index in 1..<(2 * cellCount) {
            centers.append(centers[index - 1] + centering)
        }
        
        return centers
    }
    
    private func marginMultipliers(_ cellCount:Int) -> [CGFloat] {
        let centers = centerMultipliers(cellCount)
        var margins: [CGFloat] = []
        for index in 0..<(2 * cellCount - 1) {
            margins.append(centers[index] + centering / 2)
        }
        
        return margins
    }
    
    private func yIntervals(_ cellCount:Int,  _ cellHeight: CGFloat) -> [Interval] {
        let margins = marginMultipliers(cellCount).map { $0 * cellHeight }
        let intervalFirst = Interval(min: CGFloat.leastNormalMagnitude, max: margins[0])
        var intervals: [Interval] = [intervalFirst]
        for index in 1..<(2 * cellCount - 1) {
            let interval = Interval(min: margins[index - 1], max: margins[index])
            intervals.append(interval)
        }
        let intervalLast = Interval(min: margins[2 * cellCount - 2], max: CGFloat.greatestFiniteMagnitude)
        intervals.append(intervalLast)
        
        return intervals
    }
    
    //MARK: - paging
    
    func page(for contentOffset: CGPoint) -> Int {
        var currentPage: Int = cellCenters.count - 1
        for (cellIndex, cellCenter) in cellCenters.enumerated() {
            if contentOffset.y < cellCenter {
                currentPage = cellIndex
                break
            }
        }
        
        return currentPage
    }
    
    private func yCellCenters(cellCount:Int,  cellHeight: CGFloat) -> [CGFloat] {
        guard cellCount > 0 else {return []}
        let halfCellHeight = cellHeight / 2
        let firstCellCenter = halfCellHeight
        var cellCenters:[CGFloat] = [firstCellCenter]
        guard cellCount > 1 else {return cellCenters}
        for index in 1..<cellCount {
            let previousCellCenter = cellCenters[index - 1]
            let nextCellCenter = previousCellCenter + cellHeight
            cellCenters += [nextCellCenter]
        }
        
        return cellCenters
    }
}
