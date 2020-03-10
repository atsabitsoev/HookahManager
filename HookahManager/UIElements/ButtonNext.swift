//
//  ButtonNext.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 10.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonNext: UIButton {
    
    
    @IBInspectable var cornerRadius: CGFloat = 12

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        setCorners()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
    
    
    private func setCorners() {
        layer.cornerRadius = cornerRadius
    }
    
    private func setShadow() {
        layer.shadowColor = backgroundColor?.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
    }

}

