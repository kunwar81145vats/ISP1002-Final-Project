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
        checkoutButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Home"
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
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
        
        if indexPath.row % 2 == 0
        {
            cell.quantityUpdateView.isHidden = true
        }
        else
        {
            cell.quantityUpdateView.isHidden = false
        }
        
        cell.addButton.tag = indexPath.row
        cell.increaseCountButton.tag = indexPath.row
        cell.decreaseCountButton.tag = indexPath.row
        
        cell.addButton.addTarget(self, action: #selector(addItemButtonAction(_:)), for: .touchUpInside)
        cell.increaseCountButton.addTarget(self, action: #selector(increaseItemButtonAction(_:)), for: .touchUpInside)
        cell.decreaseCountButton.addTarget(self, action: #selector(decreaseItemButtonAction(_:)), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func addItemButtonAction(_ sender: UIButton)
    {
        
    }
    
    @objc func increaseItemButtonAction(_ sender: UIButton)
    {
        
    }
    
    @objc func decreaseItemButtonAction(_ sender: UIButton)
    {
        
    }
    
}
