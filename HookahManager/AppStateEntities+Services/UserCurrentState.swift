//
//  UserCurrentState.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 14.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class UserCurrentState {
    
    static let standard = UserCurrentState()
    private init() {}
    
    
    var restaurant: Restaurant? {
        get {
            guard let restaurantDict = UserDefaults.standard.dictionary(forKey: "currentRestaurant") else {
                return nil
            }
            let restaurant = Restaurant(dict: restaurantDict)
            return restaurant
        }
        set {
            
            UserDefaults.standard.set(newValue?.dictionary, forKey: "currentRestaurant")
        }
    }
    
}
