//
//  ICalculatorPresenter.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 22/03/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ICalculatorPresenter {
    func setCollectionView(userInteraction: Bool)
    func invalidateCollectionViewTargetOffset(newTargetOffset: CGPoint)
    func tryUpdateContainerLabels()
    func tryScroll(in position: CalculationPosition)
    func addAnimations()
}

enum ContainerShowMode {
    case currentInOneFifth
    case currentInTwoFifth
    case currentInHalfSize
    case currentInFullSize
    case previousInFullSize
    
    var multiplier: CGFloat {
        switch self {
        case .currentInOneFifth:
            return 1.5
        case .currentInTwoFifth:
            return 1.5
        case .currentInHalfSize:
            return 1.5
        case .currentInFullSize:
            return 1.0
        case .previousInFullSize:
            return 2.0
        }
    }
    
    var addendum: CGFloat {
        switch self {
        case .currentInOneFifth:
            return 2
        case .currentInTwoFifth:
            return 1
        case .currentInHalfSize:
            return 0
        case .currentInFullSize:
            return 0
        case .previousInFullSize:
            return 0
        }
    }
}

enum CalculationPosition {
    case enteringFirstOperand
    case enteringOperation
    case enteringSecondOperand
    case finished
    case softDeleted
    
    var showMode: ContainerShowMode {
        switch self {
        case .enteringFirstOperand:
            return .currentInOneFifth
        case .enteringOperation:
            return .currentInTwoFifth
        case .enteringSecondOperand:
            return .currentInHalfSize
        case .finished:
            return .currentInFullSize
        case .softDeleted:
            return .previousInFullSize
        }
    }
}
