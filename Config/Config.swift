//
//  Constants.swift
//  020_test_stateMachine
//
//  Created by Oleg Kolomyitsev on 16/04/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

private let configFileName = "Config"

private enum ConfigKey: String {
    case highlightElementBorder
}

class Config {
    
    private static var container: [String: AnyObject]? {
        guard
            let path = Bundle.main.path(forResource: configFileName, ofType: "plist"),
            let container = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
                
                return nil
        }
        
        return container
    }
    
    static var highlightElementBorder: Bool {
        guard
            let container = container,
            let should = container[ConfigKey.highlightElementBorder.rawValue] as? Bool else {
                
                return false
        }

        return should
    }
}


