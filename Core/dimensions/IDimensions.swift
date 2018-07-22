//
//  IDimensions.swift
//  case6
//
//  Created by Oleg Kolomyitsev on 27/12/2017.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IDimensions {
    var space: CGFloat { get }
    var containerOffset: CGFloat { get }
    var frameInner: CGRect { get }
    var sizeOuter: CGSize { get }
    var sizeContainer: CGSize { get }
    var sizeLabel: CGSize { get }
}


