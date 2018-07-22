//
//  ICollectionViewBuilder.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 29/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ICollectionViewBuilder {
    func buildCollectionView(
        addedTo superview: UIView,
        with configure: (UICollectionView)->()) -> UICollectionView
}
