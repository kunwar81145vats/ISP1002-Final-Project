//
//  CheckoutViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func placeOrderButtonAction(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

extension CheckoutViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutItemCell", for: indexPath) as! CheckoutItemCell
        
        return cell
        
    }
    
}
