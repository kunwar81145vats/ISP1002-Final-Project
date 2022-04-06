//
//  SuccessViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //View orders button action
    @IBAction func viewOrdersButtonAction(_ sender: Any) {
        
        if let tabController = self.presentingViewController as? UITabBarController
        {
            if let currentTab = tabController.selectedViewController as? UINavigationController
            {
                currentTab.popToRootViewController(animated: false)
            }
            tabController.selectedIndex = 2
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //Cross button action
    @IBAction func crossButtonAction(_ sender: Any) {
        
        if let navController = (self.presentingViewController as? UITabBarController)?.selectedViewController as? UINavigationController
        {
            navController.popToRootViewController(animated: false)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
