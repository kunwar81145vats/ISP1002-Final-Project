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
        
    //Method to load items at app start
    func loadDataItems()
    {
        parseFromJsonFIle()
        fetchFavItems()
        fetchPastOrders()
        fetchCurrentOrder()
    }
    
    //Method to parse Json File to Model
    private func parseFromJsonFIle() {
        
        let decoder = JSONDecoder()
        
        let jsonData = readLocalJSONFile(forName: KitemsFileName)
        if let data = jsonData {
               
            do{
                if let strVal = String(data: data, encoding: .macOSRoman)
                {
                    let utf8Data = Data(strVal.utf8)
                    let jsonItems = try decoder.decode([FoodItem].self, from: utf8Data)
                    foodItems = jsonItems
                }
            }
            catch {
                printDebug(error)
            }
        }
    }
    
    //Method to read local JSON file
    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: KfileType) {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            printDebug("error: \(error)")
        }
        return nil
    }
    
    //Method to fetch favourite items
    private func fetchFavItems()
    {
        if let data = userDefaultStandard.data(forKey: KfavouriteItems) {
            do {
                favItems = try PropertyListDecoder().decode([FoodItem].self, from: data)
            } catch {
                printDebug("Unable to Decode favourite item (\(error))")
            }
        }
    }
    
    //Method to save favourite items in userdefault
    func saveFavItems()
    {
        do {
            let data = try PropertyListEncoder().encode(favItems)
            userDefaultStandard.set(data, forKey: KfavouriteItems)
        } catch {
            printDebug("Unable to Encode favourite item (\(error))")
        }
    }
    
    //Method to fetch current order in userdefault
    private func fetchCurrentOrder()
    {
        if let data = userDefaultStandard.data(forKey: KcurrentOrder) {
            do {
                currentOrder = try PropertyListDecoder().decode(Order.self, from: data)
            } catch {
                printDebug("Unable to decode Current Order (\(error))")
            }
        }
    }
    
    //Method to save current order in userdefault
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
                printDebug("Unable to Encode current order (\(error))")
            }
        }
    }
    
    //Method to fetch past orders from userdefault
    private func fetchPastOrders()
    {
        if let data = userDefaultStandard.data(forKey: KpastOrders)
        {
            do {
                pastOrders = try PropertyListDecoder().decode([Order].self, from: data)
            } catch {
                printDebug("Unable to decode past Order (\(error))")
            }
        }
    }
    
    //Method to save past orders in userdefault
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
                printDebug("Unable to decode past Order (\(error))")
            }
        }
        else
        {
            do {
                let data = try PropertyListEncoder().encode([currentOrder])
                pastOrders = [currentOrder!]
                userDefaultStandard.set(data, forKey: KpastOrders)
            } catch {
                printDebug("Unable to Encode past order (\(error))")
            }
        }
        
        currentOrder = nil
        let newOrderId = currentOrder?.orderId ?? 1 + 1
        userDefaultStandard.set(newOrderId, forKey: KcurrentOrderId)
        userDefaultStandard.removeObject(forKey: KcurrentOrder)
    }
    
    //Method used when a past order is deleted.
    func updatePastOrders()
    {
        do {
            let data = try PropertyListEncoder().encode(pastOrders)
            userDefaultStandard.set(data, forKey: KpastOrders)
        } catch {
            printDebug("Unable to Encode past order (\(error))")
        }
    }
}


//Custom Print method
//Description: Prints only in debug mode.
func printDebug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if kProduction
    {
        Swift.print(items)
    }
}
