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
            return selectedTableSizeIndex == nil ? 1 : 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "COSelectTableSizeCell") as! COSelectTableSizeCell
                cell.configure(sizes: availableTableSizes ?? [], selectedSizeIndex: selectedTableSizeIndex)
                cell.delegate = self
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "COSelectTableCell") as! COSelectTableCell
                cell.configure(tables: tablesWithSelectedSize,
                               selectedTableIndex: selectedTableIndex)
                cell.delegate = self
                return cell
                
            }
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CONameCell") as! CONameCell
            cell.configure(with: order?.customerName)
            cell.delegate = self
            return cell
            
        }
        
    }
    
}


extension CreatingOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 59
        }
    }
    
}
