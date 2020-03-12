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
    
    func fetchOrders() {
        
        let db = Firestore.firestore()
        db.collectionGroup("orders").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error)
            } else {
                for document in querySnapshot!.documents {
                    print((document.data()["orderStatus"]! as! DocumentReference)["name"])
                }
            }
        }
        
    }
    
}
