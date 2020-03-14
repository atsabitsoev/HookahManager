//
//  Order.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 09.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class Order {
    
    
    init(id: String?,
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
    
    
    var id: String?
    var number: String?
    var customerCount: Int?
    var options: [OrderOption]?
    var dateTime: Int?
    var orderStatus: OrderStatus?
    var customerName: String?
    
}


enum OrderStatus: String {
    
    case waiting
    case approved
    case deniedByUser
    case deniedByManager
    case finished
    
}


struct OrderOption: Equatable {
    
    var id: String?
    var name: String?
    
}
