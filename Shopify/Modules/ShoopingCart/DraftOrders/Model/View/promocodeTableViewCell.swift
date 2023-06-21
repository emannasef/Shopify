//
//  promocodeTableViewCell.swift
//  ShopifyCustomer
//
//  Created by Mac on 08/06/2023.
//

import UIKit

class promocodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var offerLabel: UILabel!
    
    @IBOutlet weak var promoCodeName: UILabel!
    
    @IBOutlet weak var promocodeid: UILabel!
    
    @IBOutlet weak var remaningDays: UILabel!
    
    @IBOutlet weak var applyBtn: UIButton!
    
    @IBOutlet weak var offerBg: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func applyCode(_ sender: Any) {
    }
    
    
}
