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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        checkoutButton.layer.cornerRadius = 5
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Orders"
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
    }

}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: OrderCell! = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell
        
        if cell == nil {
        
            tableView.register(UINib.init(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell
        }
        
        if indexPath.row % 2 == 0
        {
            cell.itemsLabel.text = "Item 1\nItem 2\nItem 3\nItem 4"
        }
        else
        {
            cell.itemsLabel.text = "Item 1\nItem 2\nItem 3\nItem 4\nItem 5\nItem 6\nItem 7"
        }
        
        return cell
        
    }
    
    
}
