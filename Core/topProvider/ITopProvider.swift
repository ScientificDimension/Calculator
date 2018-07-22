//
//  ITopProvider.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 02/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ITopProvider {
    var top: CGFloat { get }
    var heightStatusBar: CGFloat { get }
    var heightNavigationBar: CGFloat { get }
}
