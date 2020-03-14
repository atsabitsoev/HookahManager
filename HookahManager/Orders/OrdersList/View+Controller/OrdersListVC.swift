//
//  OrdersListVC.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 09.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class OrdersListVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = OrdersListModel()
    
    
    var orders: [Order] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadOrders()
        
    }
    
    
    private func reloadOrders() {
        
        model.fetchOrders { (orders, errorString) in
            
            guard let orders = orders else {
                print(errorString ?? "Неизвестная ошибка")
                return
            }
            
            self.orders = orders
            self.tableView.reloadData()
        }
    }
    
    
    func changeOrderStatus(_ status: OrderStatus, order: Order) {
        
        model.changeOrderStatus(order: order,
                                newStatus: status) { (succeed, errorString) in
                                    
                                    guard succeed else {
                                        print(errorString ?? "Неизвестная ошибка")
                                        return
                                    }
                                    
                                    print("Статус заказа успешно изменен")
        }
    }
    
    
    private func showCreatingOrderVC() {
        
        let storyboard = UIStoryboard(name: "CreatingOrder", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreatingOrderVC") as! CreatingOrderVC
        self.navigationController?.show(vc, sender: nil)
    }
    
    
    @IBAction func butAddTapped(_ sender: Any) {
        showCreatingOrderVC()
    }
    

}
