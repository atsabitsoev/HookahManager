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
    
    
    var orders: [Order] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadOrders()
    }
    
    
    private func reloadOrders() {
        
        let option1 = OrderOption(id: 1, name: "У окна")
        let option2 = OrderOption(id: 2, name: "Рядом с туалетом")
        
        let order1 = Order(id: 1,
                           number: "987342983",
                           customerCount: 3,
                           dateTime: 1584109800,
                           orderStatus: .waiting,
                           customerName: "Андрей Скоробогатько")
        let order2 = Order(id: 2,
                           number: "765764754",
                           customerCount: 6,
                           options: [option1, option2],
                           dateTime: 1584115200,
                           orderStatus: .approved,
                           customerName: "Петр Воняев")
        let order3 = Order(id: 3,
                           number: "7657645764",
                           customerCount: 4,
                           dateTime: 1584118800,
                           orderStatus: .approved,
                           customerName: "Ангелина Коновалова Ивановна")
        orders = [order1, order2, order3]
        tableView.reloadData()
    }
    
    
    func changeOrderStatus(_ status: OrderStatus, order: Order) {
        print("Статус сменен на \(status)")
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
