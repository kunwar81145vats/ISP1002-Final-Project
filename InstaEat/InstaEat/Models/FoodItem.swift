//
//  FoodItem.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import Foundation

struct FoodItem: Equatable, Codable
{
    let id: Int!
    let name: String!
    let desc: String!
    let img: String!
    var quantity: Int? = 0
    var isFav: Bool? = false
    
    private enum CodingKeys : String, CodingKey {
        case id, name, desc = "description", img, quantity = ""
    }

    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        lhs.id == rhs.id
    }
}
