//
//  TopProvider.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 02/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class TopProvider: ITopProvider {
    
    // MARK: - Memory Management
    
    let dimensions: IDimensions
    weak var navigationController: UINavigationController?
    
    init(dimensions: IDimensions,
        navigationController: UINavigationController? = nil) {
        self.dimensions = dimensions
        self.navigationController = navigationController
    }
    
    // MARK: - ITopProvider
    
    var top: CGFloat { return heightStatusBar + heightNavigationBar + dimensions.space}
    var heightStatusBar: CGFloat { return UIApplication.shared.statusBarFrame.height }
    var heightNavigationBar: CGFloat { return self.navigationController?.navigationBar.frame.size.height ?? 0 }
}
