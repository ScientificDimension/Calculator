//
//  Calculator.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 25/03/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit
import SwiftyStateMachine

class Calculator: ICalculator {
    
    typealias CalculatorStateMachine = StateMachine<CalculatorStateMachineSchema>
    typealias MachineTransition = (
        _ from: CalculatorState,
        _ with: CalculatorEvent,
        _ to: CalculatorState,
        _ direction: StateMachineTransitionDirection) -> ()
    
    // MARK: - Memory Management
    
    weak var view: UIView? = nil
    
    init(view: UIView) {
        view.backgroundColor = colorSchema.black
        self.view = view
    }
    
    // MARK: - ICalculator
    
    func start() {
        _ = stateMachine
        _ = keyboard
    }
    
    func refreshAnimations() {
        presenter.addAnimations()
    }
    
    // MARK: - Auxiliary
    
    lazy var colorSchema: IColorSchema = ColorSchema()
    lazy var dimensions: IDimensions = Dimensions()
    lazy var builder: ICalculatorUIBuilder = CalculatorUIBuilder(dimensions: dimensions)
    
    // MARK: - Paginator
    
    lazy var paginatorConfig = CenteringPaginatorConfig(
        cellCount: 0,
        cellHeight: dimensions.sizeOuter.height)
    
    lazy var paginator: ICenteringPaginator = CenteringPaginator(with: paginatorConfig)
    
    // MARK: - Calculations
    
    lazy var onCurrentCalculationDidChanged: ChangeCalculationPositionHandler = { [unowned self] calculationPosition in
        self.presenter.tryUpdateContainerLabels()
        self.presenter.tryScroll(in: calculationPosition)
    }
    
    lazy var calculations: ICalculationStack = CalculationStack(onCurrentCalculationDidChanged: onCurrentCalculationDidChanged)
    
    // MARK: - Calculator presenter
    
    lazy var calculationsCounter: ICalculationsCounter = CalculationsCounter(
        calculationsCount: { [unowned self] mode in
            guard mode != .previousInFullSize else {

                return self.calculations.count(softDeleted: .include) + 1
            }
            let filter: SoftDeletedFilter = self.stateMachine.transitionDirection == .forward ? .exclude : .include

            return self.calculations.count(softDeleted: filter) + 1
        },
        removeSoftDeletedCalculations: { [unowned self] in
            self.calculations.removeSoftDeletedCalculations()
    })
    
    lazy var presenter: ICalculatorPresenter = CalculatorPresenter(
        collectionView: collectionView,
        calculationsCounter: calculationsCounter,
        dimensions: dimensions,
        contentOffsetManager: ContentOffsetManager())
    
    // MARK: - CollectionView Flow
    
    lazy var calculationsFeeder: ICalculationsFeeder = CalculationsFeeder(
        calculations: { [unowned self] in self.calculations })
    
    lazy var enteringCellConfigurator: IEnteringCellConfigurator = EnteringCellConfigurator(
        isEnteringCell: { [unowned self] index in
            
            let isLastCell = index == self.calculations.count(softDeleted: .include)
            let isNotCompleted = self.stateMachine.currentState != .completed
            
            return isLastCell && isNotCompleted
        },
        calculatorStateMachine: { [unowned self] in
            return (direction: self.stateMachine.transitionDirection, state: self.stateMachine.currentState)
    })
    
    lazy var paginatorManager: IPaginatorManager = PaginatorManager(
        updateCellCount: { [unowned self]  in
            self.paginator.update(newCellCount: self.calculations.count(softDeleted: .exclude) + 1)
        },
        centeredContentOffset: { [unowned self] proposedContentOffset in
            return self.paginator.centeringContentOffset(for: proposedContentOffset)
    })
    
    lazy var presenterManager: IPresenterManager = PresenterManager(
        presenter: {[unowned self] in self.presenter })
    
    lazy var collectionViewFlow = CollectionViewFlow(
        presenterManager: presenterManager,
        calculationsFeeder: calculationsFeeder,
        enteringCellConfigurator: enteringCellConfigurator,
        paginatorManager: paginatorManager)
    
    // MARK: - State Machine
    
    lazy var schema = CalculatorSchema.schema
    
    lazy var machineTransition: MachineTransition = { previousState, event, currentState, transitionDirection in
        print(previousState, " -> ", event, " -> ", currentState, " : ", transitionDirection)
    }
    
    lazy var stateMachine = StateMachine(
        schema: schema,
        interactor: calculations,
        didTransitionCallback: machineTransition)
    
    // MARK: - CollectionView
    
    lazy var collectionViewConfigure: (UICollectionView) -> () = { [unowned self] (collectionView) in
        collectionView.register(InitialCell.self, forCellWithReuseIdentifier: "\(InitialCell.self)")
        collectionView.register(EnteringCell.self, forCellWithReuseIdentifier: "\(EnteringCell.self)")
        collectionView.register(CalculationCell.self, forCellWithReuseIdentifier: "\(CalculationCell.self)")
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = self.colorSchema.black
        DispatchQueue.main.async {
            collectionView.delegate = self.collectionViewFlow
            collectionView.dataSource = self.collectionViewFlow
        }
    }
    
    lazy var collectionView = builder.buildCollectionView(
        addedTo: view!,
        with: collectionViewConfigure)
    
    // MARK: - Keyboard
    
    lazy var keyboard = builder.buildKeyboard(
        addedTo: view!,
        onKeyPressed: { [unowned self] (_) in
            self.collectionView.isUserInteractionEnabled = false
        },
        onKeyReleased: { [unowned self] (_) in
            self.collectionView.isUserInteractionEnabled = true
        },
        keyTapHandler: { [unowned self] (key) in
            self.stateMachine.handleEvent(event: key.event)
    })
}
