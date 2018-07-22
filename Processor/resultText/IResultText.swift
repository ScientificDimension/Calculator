//
//  IResultText.swift
//  Calculator
//
//  Created by Oleg Kolomyitsev on 22/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol IResultText {
    func getText(from value: CGFloat) -> String
}
