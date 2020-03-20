//
//  CreatingOrderModel.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 21.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import Firebase


class CreatingOrderModel {
    
    func fetchAvailableTables(_ handler: @escaping (_ tables: [Table]?, _ errorString: String?) -> ()) {
        
        let db = Firestore.firestore()
        
        guard let restaurantId = UserCurrentState.standard.restaurant?.id else {
            handler(nil, "Не удалось получить id ресторана")
            return
        }
        db.collection("restaurants").document(restaurantId).collection("tables").getDocuments { (querySnap, error) in
            
            if let error = error {
                handler(nil, error.localizedDescription)
                return
            }
            
            let documents = querySnap?.documents ?? []
            let tables = documents.map { (document) -> Table in
                let docData = document.data()
                let size = docData["size"] as? [String: Any]
                return Table(id: document.documentID,
                             size: TableSize(id: size?["tableSizeId"] as? String,
                                             name: size?["name"] as? String,
                                             maxCount: size?["maxCount"] as? Int),
                             options: docData["options"] as? [String])
            }
            
            handler(tables, nil)
        }
    }
    
}
