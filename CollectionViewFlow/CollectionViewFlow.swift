//
//  CollectionViewFlow.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 01/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CollectionViewFlow: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: -
    
    var presenterManager: IPresenterManager
    let calculationsFeeder: ICalculationsFeeder
    let enteringCellConfigurator: IEnteringCellConfigurator
    let paginatorManager: IPaginatorManager

    // MARK: - memoryManagement
    
    init(
        presenterManager: IPresenterManager,
        calculationsFeeder: ICalculationsFeeder,
        enteringCellConfigurator: IEnteringCellConfigurator,
        paginatorManager: IPaginatorManager) {
        self.presenterManager = presenterManager
        self.calculationsFeeder = calculationsFeeder
        self.enteringCellConfigurator = enteringCellConfigurator
        self.paginatorManager = paginatorManager
        super.init()
    }
    
    //MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paginatorManager.updateCellCount()

        return calculationsFeeder.count + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row > 0 else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "\(InitialCell.self)", for: indexPath)
        }
        let calculation = calculationsFeeder[indexPath.row - 1]! 
        guard !enteringCellConfigurator.isEnteringCell(index: indexPath.row) else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EnteringCell.self)", for: indexPath) as! CalculatorCell
            cell.configure(calculation)
            enteringCellConfigurator.set(enteringCell: cell)
            enteringCellConfigurator.tryConfigureEnteringCell(transitionDirectionIsForward: false)

            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calculation.operation.type.cellId, for: indexPath) as! CalculatorCell
        cell.configure(calculation)
        cell.removeAnimations() //TOOD: add protocol extension refreshAnimations()
        cell.addAnimations()
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // This is so that the user does not bring down the content offset and cell will appear always for bottom (not from top when content offset is brought down)
        presenterManager.setCollectionView(userInteraction: calculationsFeeder.isEmpty ? false : true)
        
        if scrollView.isTracking {
            presenterManager.invalidateCollectionViewTargetOffset(newTargetOffset: scrollView.contentOffset)
        }
    }
    

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        calculationsFeeder.removeSoftDeletedCalculations()
        presenterManager.tryUpdateContainerLabels()
        enteringCellConfigurator.tryConfigureEnteringCell(transitionDirectionIsForward: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = paginatorManager.centeredContentOffset(targetContentOffset.pointee)
    }
}
