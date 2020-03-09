//
//  OrdersListTableview.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 09.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


//MARK: Delegate
extension OrdersListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentOrder = orders[indexPath.row]
        let denieActionTitle = currentOrder.orderStatus == .waiting ? "Отклонить" : "Отменить"
        let denieAction = UIContextualAction(style: .destructive,
                                             title: denieActionTitle) { (action, _, _) in
                                                
                                                self.changeOrderStatus(.deniedByManager, order: currentOrder)
                                                self.orders.remove(at: indexPath.row)
                                                tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [denieAction])
        return swipeConfiguration
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentOrder = orders[indexPath.row]
        let isWaiting = currentOrder.orderStatus == .waiting
        let confirmActionTitle = isWaiting ? "Подтвердить" : "Гость ушел"
        let confirmAction = UIContextualAction(style: .normal,
                                             title: confirmActionTitle) { (action, view, _) in
                                                
                                                let currentOrder = self.orders[indexPath.row]
                                                let newOrderStatus = currentOrder.orderStatus == .waiting ? OrderStatus.approved : OrderStatus.finished
                                                
                                                if newOrderStatus == .approved {
                                                    currentOrder.orderStatus = OrderStatus.approved
                                                    tableView.reloadSections([indexPath.section], with: .automatic)
                                                } else {
                                                    self.orders.remove(at: indexPath.row)
                                                    tableView.deleteRows(at: [indexPath], with: .automatic)
                                                }
                                                
                                                self.changeOrderStatus(newOrderStatus, order: currentOrder)

        }
        confirmAction.backgroundColor = currentOrder.orderStatus == .some(.waiting) ? .systemGreen : .systemBlue
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [confirmAction])
        return swipeConfiguration
    }
    
}


//MARK: Data Source
extension OrdersListVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentOrder = orders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersListOrderCell") as! OrdersListOrderCell
        cell.configure(with: currentOrder)
        return cell
    }
    
    
}

