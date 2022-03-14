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
        
        self.title = "Favourites"
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
    }

}


extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate
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
        return cell
        
    }
    
}
