//
//  CheckoutViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var orderButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateCountLabel()
        tableView.rowHeight = 75
    }
    
    //Update total item count method
    func updateCountLabel()
    {
        var totalCount = 0
        for obj in Common.shared.currentOrder?.items ?? []
        {
            totalCount += obj.quantity ?? 1
        }
        totalCountLabel.text = "\(totalCount)"
    }
    
    //Place order button action
    @IBAction func placeOrderButtonAction(_ sender: Any) {
        
        Common.shared.savePastOrder()
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

//MARK: - UITableview Datasouce and Delegate
extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.shared.currentOrder?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutItemCell", for: indexPath) as! CheckoutItemCell
        
        let foodObj = Common.shared.currentOrder?.items?[indexPath.row]
        
        cell.nameLabel.text = foodObj?.name
        cell.quantityLabel.text = "\(foodObj?.quantity ?? 1)"
        
        cell.increaseButton.tag = indexPath.row
        cell.decreaseButton.tag = indexPath.row
        
        cell.increaseButton.addTarget(self, action: #selector(increaseItemButtonAction(_:)), for: .touchUpInside)
        cell.decreaseButton.addTarget(self, action: #selector(decreaseItemButtonAction(_:)), for: .touchUpInside)

        return cell
    }
    
    //+ button action
    @objc func increaseItemButtonAction(_ sender: UIButton)
    {
        Common.shared.currentOrder?.items?[sender.tag].quantity! += 1
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        updateCountLabel()
    }
    
    //- button action
    @objc func decreaseItemButtonAction(_ sender: UIButton)
    {
        Common.shared.currentOrder?.items?[sender.tag].quantity! -= 1
        if Common.shared.currentOrder?.items?[sender.tag].quantity ?? 0 == 0
        {
            Common.shared.currentOrder?.items?.remove(at: sender.tag)
            tableView.reloadData()
        }
        else
        {
            tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        }
        if Common.shared.currentOrder?.items?.count == 0
        {
            Common.shared.currentOrder = nil
            tableView.isHidden = true
            orderButtonHeightConstraint.constant = 0
        }
        updateCountLabel()
    }
    
}
