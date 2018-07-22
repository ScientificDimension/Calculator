//
//  UICollectionViewLayout+CopyAttributes.swift
//  Resistance
//
//  Created by Oleg Kolomyitsev on 2/22/17.
//  Copyright © 2017 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {
    /*
     the problem:
     
     UICollectionViewFlowLayout has cached frame mismatch for index path <NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0} - cached value: {{0, 8.3333333333333428}, {414, 300}}; expected value: {{0, 0}, {414, 300}}
     2017-02-22 16:15:33.354386 Resistance[7224:1923072] This is likely occurring because the flow layout subclass Resistance.ResistanceCellCollectionViewLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
     */
    
    /*
     the solution:
     
     http://stackoverflow.com/questions/31508153/warning-uicollectionviewflowlayout-has-cached-frame-mismatch-for-index-path-ab
     http://stackoverflow.com/questions/31771089/when-using-subclassed-collectionviewflowlayout-im-getting-weird-error
     */

    func copyCells<T:UICollectionViewLayoutAttributes>(_ cells: [T]) -> [T]? {
        return cells.map { $0.copy() } as? [T]
    }
}
