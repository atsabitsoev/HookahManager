//
//  IntExtensions.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 09.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


extension Int {
    
    func getDateStringFromSeconds(dateFormat: String) -> String {

        let date = Date(timeIntervalSince1970: Double(self))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC3")
        formatter.dateFormat = dateFormat
        let string = formatter.string(from: date)
        return string
    }
    
}
