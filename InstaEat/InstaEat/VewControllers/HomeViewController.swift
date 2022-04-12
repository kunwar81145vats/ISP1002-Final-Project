//
//  HomeViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Common.shared.foodItems.count == 0
        {
            Common.shared.loadDataItems()
        }
        self.title = NSLocalizedString("Home", comment: "")
        updateCheckoutButton()
        tableView.reloadData()
    }
    
    //Update checkout button on item quantity change
    func updateCheckoutButton()
    {
        checkoutButton.layer.cornerRadius = 5
        
        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)

        if Common.shared.currentOrder == nil
        {
            checkoutButton.isHidden = true
        }
        else
        {
            if let order = Common.shared.currentOrder
            {
                if order.items?.count == 0
                {
                    checkoutButton.isHidden = true
                }
                else
                {
                    checkoutButton.isHidden = false
                }
            }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Back", comment: ""), style: .plain, target: nil, action: nil)
    }

}

//MARK: - UITableview Datasouce and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.shared.foodItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ItemCell! = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell

        if cell == nil {
            
            tableView.register(UINib.init(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell
        }
        
        let foodObject = Common.shared.foodItems[indexPath.row]
        
        if let obj = Common.shared.currentOrder?.items?.first(where: { item in
            item.id == foodObject.id
        })
        {
            if obj.quantity == 0
            {
                cell.quantityUpdateView.isHidden = true
            }
            else
            {
                cell.quantityLabel.text = "\(obj.quantity ?? 1)"
                cell.quantityUpdateView.isHidden = false
            }
        }
        else
        {
            cell.quantityUpdateView.isHidden = true
        }
        
        if Common.shared.favItems.contains(where: { item in
            item.id == foodObject.id
        })
        {
            cell.favImageView.image = UIImage(named: "selectedFavourites")
        }
        else
        {
            cell.favImageView.image = UIImage(named: "addToFavourite")
        }
        
        cell.addButton.tag = indexPath.row
        cell.increaseCountButton.tag = indexPath.row
        cell.decreaseCountButton.tag = indexPath.row
        cell.favButton.tag = indexPath.row
        
        cell.favButton.addTarget(self, action: #selector(favButtonAction(_:)), for: .touchUpInside)
        cell.addButton.addTarget(self, action: #selector(addItemButtonAction(_:)), for: .touchUpInside)
        cell.increaseCountButton.addTarget(self, action: #selector(increaseItemButtonAction(_:)), for: .touchUpInside)
        cell.decreaseCountButton.addTarget(self, action: #selector(decreaseItemButtonAction(_:)), for: .touchUpInside)
        
        cell.nameLabel.text = foodObject.name
        cell.descripLabel.text = foodObject.desc
        cell.itemImageView.image = UIImage(named: foodObject.img)
        
        return cell
        
    }
    
    //Add Item button action
    @objc func addItemButtonAction(_ sender: UIButton)
    {
        let orderId: Int = UserDefaults.standard.value(forKey: KcurrentOrderId) as? Int ?? 1
        var orderObj = Order(orderId: orderId)
        var item = Common.shared.foodItems[sender.tag]
        item.quantity = 1
        orderObj.items = [item]
        
        if Common.shared.currentOrder == nil
        {
            Common.shared.currentOrder = orderObj
        }
        else
        {
            Common.shared.currentOrder?.items?.append(contentsOf: orderObj.items ?? [])
        }
        Common.shared.saveCurrentOrder()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        checkoutButton.isHidden = false
    }
    
    //+ button action
    @objc func increaseItemButtonAction(_ sender: UIButton)
    {
        if let ind = Common.shared.currentOrder?.items?.firstIndex(where: { item in
            item.id == Common.shared.foodItems[sender.tag].id
        })
        {
            Common.shared.currentOrder?.items?[ind].quantity! += 1
        }
        Common.shared.saveCurrentOrder()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    //- button action
    @objc func decreaseItemButtonAction(_ sender: UIButton)
    {
        if let ind = Common.shared.currentOrder?.items?.firstIndex(where: { item in
            item.id == Common.shared.foodItems[sender.tag].id
        })
        {
            Common.shared.currentOrder?.items?[ind].quantity! -= 1
            if Common.shared.currentOrder?.items?[ind].quantity ?? 0 == 0
            {
                Common.shared.currentOrder?.items?.remove(at: ind)
                tableView.reloadData()
            }
            else
            {
                tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
            }
        }
        if Common.shared.currentOrder?.items?.count == 0
        {
            checkoutButton.isHidden = true
            Common.shared.currentOrder = nil
        }
        
        Common.shared.saveCurrentOrder()
    }
    
    //Favourite button action
    @objc func favButtonAction(_ sender: UIButton)
    {
        if let ind =  Common.shared.favItems.firstIndex(where: { obj in
            obj.id == Common.shared.foodItems[sender.tag].id
        })
        {
            Common.shared.favItems.remove(at: ind)
        }
        else
        {
            Common.shared.favItems.append(Common.shared.foodItems[sender.tag])
        }
        
        tableView.reloadRows(at: [IndexPath.init(row: sender.tag, section: 0)], with: .automatic)
        Common.shared.saveFavItems()
    }
    
}
