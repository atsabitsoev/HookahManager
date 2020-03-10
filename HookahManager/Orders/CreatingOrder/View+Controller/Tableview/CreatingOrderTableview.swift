//
//  CreatingOrderTableview.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 10.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension CreatingOrderVC: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return configuration?.availableOptions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "COCustomerCountCell") as! COCustomerCountCell
            cell.delegate = self
            if let configuration = configuration {
                cell.stepperCustomersCount.maximumValue = Double(configuration.maxCustomerCount)
            }
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "COOrderOptionCell") as! COOrderOptionCell
            cell.delegate = self
            guard let currentOrderOption = configuration?.availableOptions[indexPath.row] else { return UITableViewCell() }
            let isIncluded = order?.options?.contains(currentOrderOption) ?? false
            cell.fill(with: currentOrderOption, isIncluded: isIncluded)
            return cell
            
        }
        
    }
    
    
}


extension CreatingOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 153
        } else {
            return 44
        }
    }
    
}
