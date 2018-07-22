//
//  CollectionViewBuilder.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 29/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class CollectionViewBuilder: ICollectionViewBuilder {
    
    // MARK: - Memory Management
    
    let topProvider: ITopProvider
    let dimensions: IDimensions
    
    init(dimensions: IDimensions,
         navigationController: UINavigationController? = nil) {
        self.dimensions = dimensions
        self.topProvider = TopProvider(
            dimensions: dimensions,
            navigationController: navigationController)
    }

    // MARK: - ICollectionViewBuilder
    
    func buildCollectionView(
        addedTo superview: UIView,
        with configure: (UICollectionView)->()) -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: ContainerCellCollectionViewLayout())
        add(collectionView, to: superview)
        configure(collectionView)

        return collectionView
    }
    
    // MARK: -
    
    private func add(_ collectionView: UICollectionView, to superview: UIView) {
        superview.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: superview.topAnchor, constant: topProvider.top).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: dimensions.sizeOuter.height).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: dimensions.sizeOuter.width).isActive = true
        if Config.highlightElementBorder {
            collectionView.layer.borderWidth = 1
            collectionView.layer.borderColor = UIColor.red.cgColor
        }
    }
}
