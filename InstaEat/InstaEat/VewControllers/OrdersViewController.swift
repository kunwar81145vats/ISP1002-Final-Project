//
//  OrdersViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = NSLocalizedString("Orders", comment: "")
        self.tableView.reloadData()
        updateCheckoutButton()
        
        if Common.shared.pastOrders.count == 0
        {
            tableView.isHidden = true
            noDataLabel.isHidden = false
        }
        else
        {
            tableView.isHidden = false
            noDataLabel.isHidden = true
        }
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
extension OrdersViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.shared.pastOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: OrderCell! = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell
        
        if cell == nil {
        
            tableView.register(UINib.init(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell
        }
        
        let order = Common.shared.pastOrders[indexPath.row]
        
        cell.titleLabel.text = NSLocalizedString("Order", comment: "") + " #" + "\(order.orderId ?? 1)"
        
        var itemsText: String = ""
        for item in order.items ?? []
        {
            let name = item.name
            itemsText += "\(item.quantity ?? 1)  \(name ?? "")\n\n"
        }
        
        itemsText.removeLast(2)
        cell.itemsLabel.text = itemsText
        
        return cell
        
    }
}
