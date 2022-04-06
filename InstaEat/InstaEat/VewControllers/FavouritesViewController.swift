//
//  FavouritesViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkoutButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = NSLocalizedString("Favourites", comment: "")
        tableView.reloadData()
        updateCheckoutButton()
        tableView.isHidden = Common.shared.favItems.count == 0 ? true : false
    }
    
    //Update checkout button
    func updateCheckoutButton()
    {
        checkoutButton.layer.cornerRadius = 5
        
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
extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.shared.favItems.count
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
        
        let foodObject = Common.shared.favItems[indexPath.row]
        
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
        
        cell.favImageView.image = UIImage(named: "selectedFavourites")
        
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
    
    //Add item button action
    @objc func addItemButtonAction(_ sender: UIButton)
    {
        var orderObj = Order(orderId: 1)
        var item = Common.shared.foodItems[sender.tag]
        item.quantity = 1
        orderObj.items = [item]
        
        if Common.shared.currentOrder == nil
        {
            Common.shared.currentOrder = orderObj
            Common.shared.saveCurrentOrder()
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
        Common.shared.favItems.remove(at: sender.tag)
        tableView.reloadData()
        Common.shared.saveFavItems()
    }
    
}
