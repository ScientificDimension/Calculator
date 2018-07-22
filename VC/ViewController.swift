//
//  ViewController.swift
//  Calculator
//
//  Created by Oleg Kolomyitsev on 20/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var calculator: ICalculator = Calculator(view: view)

    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculator.refreshAnimations()
    }
}

