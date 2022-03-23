//
//  Order.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import Foundation

struct Order: Equatable, Codable
{
    let orderId: Int!
    var items: [FoodItem]?
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.orderId == rhs.orderId
    }
}
