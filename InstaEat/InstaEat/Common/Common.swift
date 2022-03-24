//
//  Common.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class Common: NSObject {

    static let shared = Common()
    
    let userDefaultStandard = UserDefaults.standard
    
    var foodItems: [FoodItem] = []
    var currentOrder: Order?
    var favItems: [FoodItem] = []
    var pastOrders: [Order] = []
        
    func loadDataItems()
    {
        parseFromJsonFIle()
        fetchFavItems()
        fetchPastOrders()
        fetchCurrentOrder()
    }
    
    private func parseFromJsonFIle() {
        
        let decoder = JSONDecoder()
        
        let jsonData = readLocalJSONFile(forName: KitemsFileName)
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
    
    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: KfileType) {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    private func fetchFavItems()
    {
        if let data = userDefaultStandard.data(forKey: KfavouriteItems) {
            do {
                favItems = try PropertyListDecoder().decode([FoodItem].self, from: data)
            } catch {
                print("Unable to Decode favourite item (\(error))")
            }
        }
    }
    
    func saveFavItems()
    {
        do {
            let data = try PropertyListEncoder().encode(favItems)
            userDefaultStandard.set(data, forKey: KfavouriteItems)
        } catch {
            print("Unable to Encode favourite item (\(error))")
        }
    }
    
    private func fetchCurrentOrder()
    {
        if let data = userDefaultStandard.data(forKey: KcurrentOrder) {
            do {
                currentOrder = try PropertyListDecoder().decode(Order.self, from: data)
            } catch {
                print("Unable to decode Current Order (\(error))")
            }
        }
    }
    
    func saveCurrentOrder()
    {
        if currentOrder == nil
        {
            userDefaultStandard.removeObject(forKey: KcurrentOrder)
        }
        else
        {
            do {
                let data = try PropertyListEncoder().encode(currentOrder)
                userDefaultStandard.set(data, forKey: KcurrentOrder)
            } catch {
                print("Unable to Encode current order (\(error))")
            }
        }
    }
    
    private func fetchPastOrders()
    {
        if let data = userDefaultStandard.data(forKey: KpastOrders)
        {
            do {
                pastOrders = try PropertyListDecoder().decode([Order].self, from: data)
                print(pastOrders.count)
            } catch {
                print("Unable to decode past Order (\(error))")
            }
        }
    }
    
    func savePastOrder()
    {
        if let data = userDefaultStandard.data(forKey: KpastOrders)
        {
            do {
                var orders = try PropertyListDecoder().decode([Order].self, from: data)
                if let order = currentOrder
                {
                    orders.append(order)
                    pastOrders = orders
                    let newData = try PropertyListEncoder().encode(orders)
                    userDefaultStandard.set(newData, forKey: KpastOrders)
                }
                
            } catch {
                print("Unable to decode past Order (\(error))")
            }
        }
        else
        {
            do {
                let data = try PropertyListEncoder().encode([currentOrder])
                pastOrders = [currentOrder!]
                userDefaultStandard.set(data, forKey: KpastOrders)
            } catch {
                print("Unable to Encode past order (\(error))")
            }
        }
        
        currentOrder = nil
        let newOrderId = currentOrder?.orderId ?? 1 + 1
        userDefaultStandard.set(newOrderId, forKey: KcurrentOrderId)
        userDefaultStandard.removeObject(forKey: KcurrentOrder)
    }
}
