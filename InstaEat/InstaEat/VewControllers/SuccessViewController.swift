//
//  SuccessViewController.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var successImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImageView()
    }
    
    //Animate success imageview
    func animateImageView()
    {
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.successImageView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 1.0, animations: {() -> Void in
                self.successImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
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
