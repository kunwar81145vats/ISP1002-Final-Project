//
//  Common.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class Common: NSObject {

    static let shared = Common()
    var foodItems: [FoodItem] = []
    var currentOrder: Order?
    var favItems: [FoodItem] = []
    
    func parseFromJsonFIle() {
        
        let decoder = JSONDecoder()
        
        let jsonData = readLocalJSONFile(forName: "FoodItems")
        if let data = jsonData {
               
            do{
                
                let jsonItems = try decoder.decode([FoodItem].self, from: data)
                foodItems = jsonItems
            }
            catch {
                print(error)
            }
        }
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
