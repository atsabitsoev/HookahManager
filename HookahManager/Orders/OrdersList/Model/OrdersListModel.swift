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
                
                let optionsDict = document["options"] as? [[String: Any]]
                let options = optionsDict?.compactMap({ (dict) -> OrderOption? in
                    return OrderOption(id: dict["id"] as? String,
                                       name: dict["name"] as? String)
                })
                
                let dateTimeTimeStamp = (docData["dateTime"] as? Timestamp)
                let dateTime = Int((dateTimeTimeStamp?.seconds ?? 0))
                
                let order = Order(id: document.documentID,
                                  number: docData["number"] as? String,
                                  customerCount: docData["customerCount"] as? Int,
                                  options: options,
                                  dateTime: dateTime,
                                  orderStatus: OrderStatus(rawValue: (docData["status"] as? String ?? "")),
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
