//
//  Restaurant.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 14.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


struct Restaurant {
    
    
    init?(dict: [String: Any?]) {
        
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.address = dict["address"] as? String
    }
    
    var dictionary: [String: Any?] {
        get {
            return ["id": id,
                    "name": name,
                    "address": address]
        }
    }
    
    
    init(id: String?,
         name: String?,
         address: String?) {
        
        self.id = id
        self.name = name
        self.address = address
    }
    
    
    var id: String?
    var name: String?
    var address: String?
    
}
