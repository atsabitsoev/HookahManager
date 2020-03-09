//
//  OrdersListOrderCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 09.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class OrdersListOrderCell: UITableViewCell {
    
    
    @IBOutlet weak var labDateTime: UILabel!
    @IBOutlet weak var labCustomersCount: UILabel!
    @IBOutlet weak var stackOptions: UIStackView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labNumber: UILabel!
    @IBOutlet weak var viewStatusColor: UIView!
    
    
    func configure(with order: Order) {
        
        labDateTime.text = order.dateTime?.getDateStringFromSeconds(dateFormat: "HH:mm, dd MMMM")
        labCustomersCount.text = getPersonCountString(count: order.customerCount ?? 0)
        labName.text = order.customerName
        labNumber.text = "№\(order.number ?? "null")"
        viewStatusColor.backgroundColor = order.orderStatus == .some(.waiting) ? .systemYellow : .systemGreen
        setStackOptions(order.options ?? [])
    }
    
    
    private func getPersonCountString(count: Int) -> String {
        
        var personCountAddingString = ""
        if count >= 11 && count <= 14 {
            personCountAddingString = "персон"
        } else {
            switch "\(count)".last {
            case "1":
                personCountAddingString = "персона"
            case "2", "3", "4":
                personCountAddingString = "персоны"
            default:
                personCountAddingString = "персон"
            }
        }
        return "\(count) \(personCountAddingString)"
    }
    
    
    private func setStackOptions(_ options: [OrderOption]) {
        
        let labels = options.map { (option) -> UILabel in
            let label = UILabel()
            label.text = "– " + option.name
            return label
        }
        stackOptions.arrangedSubviews.forEach { (view) in
            stackOptions.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        labels.forEach { (label) in
            self.stackOptions.addArrangedSubview(label)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
