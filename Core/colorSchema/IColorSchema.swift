//
//  IColorSchema.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 21/01/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

public protocol IColorSchema {
    var black: UIColor { get }
    var white: UIColor { get }
    var dark: UIColor { get }
    var gray: UIColor { get }
    var orange: UIColor { get }
}
