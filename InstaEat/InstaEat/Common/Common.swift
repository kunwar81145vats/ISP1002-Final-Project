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
    var favItems: [FoodItem] = [] {
        didSet {
            saveFavItems()
        }
    }
    
    func loadDataItems()
    {
        parseFromJsonFIle()
        fetchFavItems()
    }
    private func parseFromJsonFIle() {
        
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
    
    private func fetchFavItems()
    {
        if let data = UserDefaults.standard.data(forKey: KfavouriteItems) {
            do {
                let decoder = JSONDecoder()
                favItems = try decoder.decode([FoodItem].self, from: data)
            } catch {
                print("Unable to Decode Note (\(error))")
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
    
    func saveFavItems()
    {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favItems)

            UserDefaults.standard.set(data, forKey: KfavouriteItems)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
}
