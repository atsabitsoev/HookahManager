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
         table: Table?,
         dateTime: Int?,
         orderStatus: OrderStatus?,
         customerName: String?) {
        
        self.id = id
        self.number = number
        self.table = table
        self.dateTime = dateTime
        self.orderStatus = orderStatus
        self.customerName = customerName
    }
    
    
    var id: String?
    var number: String?
    var table: Table?
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


struct Table: Equatable {
    
    var id: String?
    var size: TableSize?
    var options: [String]?
    
}


struct TableSize: Equatable {
    
    var id: String?
    var name: String?
    var maxCount: Int?
    
}
