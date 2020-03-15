//
//  OrdersListModel.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 11.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Firebase


class OrdersListModel {
    
    
    private let db = Firestore.firestore()
    
    
    //MARK: Fetch Orders
    func fetchOrders(_ handler: @escaping (_ orders: [Order]?, _ errorString: String?) -> ()) {
                
        guard let restaurantId = UserCurrentState.standard.restaurant?.id else {
            handler(nil, "Невозможно определить ресторан")
            return
        }
        
        db.collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .whereField("status", in: ["waiting", "approved"])
            .addSnapshotListener { (querySnap, error) in
            
            guard error == nil else {
                print(error!)
                handler(nil, error?.localizedDescription)
                return
            }
            
            guard let documents = querySnap?.documents else {
                print("Неизвестная ошибка")
                return
            }
            
            let orders = documents.compactMap { (document) -> Order? in
                
                let docData = document.data()
                
                let tableDict = docData["table"] as? [String: Any]
                let tableSizeDict = tableDict?["size"] as? [String: Any]
                let tableSize = TableSize(id: tableSizeDict?["tableSizeId"] as? String,
                                          name: tableSizeDict?["name"] as? String,
                                          maxCount: tableSizeDict?["maxCount"] as? Int)
                let table = Table(id: tableDict?["tableId"] as? String,
                                  size: tableSize,
                                  options: tableDict?["options"] as? [String])
                
                let dateTimeInt64 = (docData["dateTime"] as? Timestamp)?.seconds ?? 0
                let dateTime = Int(dateTimeInt64)
                
                let order = Order(id: document.documentID,
                                  number: docData["number"] as? String,
                                  table: table,
                                  dateTime: dateTime,
                                  orderStatus: OrderStatus(rawValue: docData["status"] as? String ?? ""),
                                  customerName: docData["customerName"] as? String)
                return order
            }
            
            handler(orders, nil)
            
        }
        
    }
    
    
    //MARK: Change Order Status
    func changeOrderStatus(order: Order,
                           newStatus: OrderStatus,
                           _ handler: @escaping (_ result: Bool, _ errorString: String?) -> ()) {
        
        guard let id = order.id else {
            handler(false, "Невозможно получить id заказа")
            return
        }
        
        guard let restaurantId = UserCurrentState.standard.restaurant?.id else {
            handler(false, "Ресторан не определен")
            return
        }
        
        db.collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .document(id)
            .updateData(["status": newStatus.rawValue]) { (error) in
                
            if let error = error {
                handler(false, error.localizedDescription)
                return
            } else {
                handler(true, nil)
            }
        }
        
    }
    
}
