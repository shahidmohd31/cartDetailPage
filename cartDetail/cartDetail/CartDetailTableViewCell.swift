//
//  CartDetailTableViewCell.swift
//  cartDetail
//
//  Created by shahid mohd on 15/09/18.
//  Copyright © 2018 shahidmohd. All rights reserved.
//

import UIKit

class CartDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var mp: UILabel!
    @IBOutlet weak var sp: UILabel!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var prodImage: UIImageView!
    
    @IBOutlet weak var sizeOrweight: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
