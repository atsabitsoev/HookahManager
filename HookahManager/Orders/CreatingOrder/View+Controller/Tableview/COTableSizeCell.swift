//
//  COTableSizeCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 15.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class COTableSizeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labSizeName: UILabel!
    @IBOutlet weak var labCustomerCount: UILabel!
    
    
    func configure(size: TableSize, selected: Bool) {
        
        labSizeName.text = size.name
        let count = size.maxCount ?? 0
        labCustomerCount.text = "до \(count) человек"
        
        viewBackground.backgroundColor = selected ? #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1) : #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
    }
    
}
