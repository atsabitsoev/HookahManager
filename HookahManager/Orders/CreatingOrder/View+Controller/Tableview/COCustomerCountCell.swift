//
//  COCustomerCountCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 10.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol COCustomerCountCellDelegate {
    func customerCountChanged(to count: Int)
}


class COCustomerCountCell: UITableViewCell {
    
    
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labCount: UILabel!
    @IBOutlet weak var stepperCustomersCount: UIStepper!
    
    
    var delegate: COCustomerCountCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func setNewCustomerCount(_ count: Int) {
        labCount.text = "\(count)"
        delegate?.customerCountChanged(to: count)
    }
    

    @IBAction func stepperCustomersCountChanged(_ sender: UIStepper) {
        let newValue = Int(sender.value)
        setNewCustomerCount(newValue)
    }
    
    
}

