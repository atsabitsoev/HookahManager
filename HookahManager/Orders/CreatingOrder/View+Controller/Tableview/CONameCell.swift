//
//  CONameCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 11.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol CONameCellDelegate {
    func nameChanged(to name: String?)
}


class CONameCell: UITableViewCell {
    
    
    @IBOutlet weak var tfName: UITextField!
    
    
    var delegate: CONameCellDelegate?
    
    
    func configure(with name: String?) {
        tfName.text = name
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        tfName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CONameCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.nameChanged(to: textField.text)
    }
    
}
