//
//  Order.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 09.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class Order {
    
    
    init(id: Int?,
         number: String?,
         customerCount: Int?,
         options: [OrderOption]? = [],
         dateTime: Int?,
         orderStatus: OrderStatus?,
         customerName: String?) {
        
        self.id = id
        self.number = number
        self.customerCount = customerCount
        self.options = options
        self.dateTime = dateTime
        self.orderStatus = orderStatus
        self.customerName = customerName
    }
    
    
    var id: Int?
    var number: String?
    var customerCount: Int?
    var options: [OrderOption]?
    var dateTime: Int?
    var orderStatus: OrderStatus?
    var customerName: String?
    
}


enum OrderStatus: Int {
    
    case waiting = 1
    case approved = 2
    case deniedByUser = 3
    case deniedByManager = 4
    case finished = 5
    
}


struct OrderOption {
    
    var id: Int
    var name: String
    
}
