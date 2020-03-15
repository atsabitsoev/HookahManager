//
//  COTableCellCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 15.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class COTableCell: UICollectionViewCell {
    
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labOptions: UILabel!
    
    
    func configure(options: [String]?, selected: Bool) {
        
        guard let options = options else {
            labOptions.text = "Без дополнительных опций"
            return
        }
        
        let optionsWithDefises = options.map({ (option) -> String in
            return "– \(option)"
        })
        let resultString = optionsWithDefises.joined(separator: "\n")
        labOptions.text = resultString
        
        viewBackground.backgroundColor = selected ? #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1) : #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
    }
    
}
