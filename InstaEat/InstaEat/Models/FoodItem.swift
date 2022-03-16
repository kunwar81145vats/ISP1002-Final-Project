//
//  FoodItem.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import Foundation

struct FoodItem: Equatable
{
    let id: Int!
    let name: String?
    let desc: String?
    let img: String?
    
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        lhs.id == rhs.id
    }
}
