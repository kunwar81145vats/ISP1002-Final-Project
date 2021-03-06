//
//  ItemCell.swift
//  InstaEat
//
//  Created by Kunwar Vats on 14/03/22.
//

import UIKit

class ItemCell: UITableViewCell {
   
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityUpdateView: UIView!
    @IBOutlet weak var increaseCountButton: UIButton!
    @IBOutlet weak var decreaseCountButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addButton.layer.cornerRadius = 5
        itemImageView.layer.cornerRadius = 5
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.borderWidth = 0.5
        quantityUpdateView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
