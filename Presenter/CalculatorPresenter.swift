//
//  CalculatorPresenter.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 03/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CalculatorPresenter: ICalculatorPresenter {
    
    // MARK: - UI
    
    private weak var collectionView: UICollectionView? = nil
    
    // MARK: -
    
    let calculationsCounter: ICalculationsCounter
    let dimensions: IDimensions
    let contentOffsetManager:IContentOffsetManager
    
    // MARK: - Memory Management
    
    init (collectionView: UICollectionView,
          calculationsCounter: ICalculationsCounter,
          dimensions: IDimensions,
          contentOffsetManager: IContentOffsetManager)
    {
        self.collectionView = collectionView
        self.calculationsCounter = calculationsCounter
        self.dimensions = dimensions
        self.contentOffsetManager = contentOffsetManager
        
        //TODO: add sender pattern
        NotificationCenter.default.addObserver(
            self, selector: #selector(CalculatorPresenter.addAnimations),
            name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: -
    
    @objc
    func addAnimations() {
        collectionView?.visibleCells.forEach { (cell) in
            if let cell = cell as? IAnimatable {
                cell.addAnimations()
            }
        }
    }
    
    // MARK: -
    
    func invalidateCollectionViewTargetOffset(newTargetOffset: CGPoint) {
        contentOffsetManager.invalidateTargetOffset(newTargetOffset)
    }
    
    // MARK: -
    
    func tryUpdateContainerLabels() {
        collectionView?.reloadData()
    }
    
    func tryScroll(in position: CalculationPosition) {
        trySetCollectionViewContentOffset(yDesired: yDesired(for: position.showMode))
    }
    
    func setCollectionView(userInteraction: Bool) {
        collectionView?.isUserInteractionEnabled = userInteraction
    }
    
    // MARK: -
    
    private func yDesired(for mode: ContainerShowMode ) -> CGFloat {
        var y = dimensions.sizeOuter.height
        y *= CGFloat(calculationsCounter.calculationsCount(mode)) - mode.multiplier
        y -= dimensions.sizeLabel.height * mode.addendum
        
        return y
    }

    private func trySetCollectionViewContentOffset(yDesired: CGFloat) {
        guard let collectionView = collectionView else {
            return
        }
        let currentOffset = collectionView.contentOffset
        let desiredOffset = CGPoint(x: currentOffset.x, y: yDesired)
        contentOffsetManager.trySet(
            collectionView,
            desiredOffset: desiredOffset,
            animated: true,
            onNoNeedScrolling: {
                self.calculationsCounter.removeSoftDeletedCalculations()
        })
    }
}
