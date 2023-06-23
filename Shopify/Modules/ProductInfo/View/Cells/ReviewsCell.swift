//
//  ReviewsCell.swift
//  ShopifyCustomer
//
//  Created by Mac on 11/06/2023.
//

import UIKit
import Cosmos
class ReviewsCell: UITableViewCell {
    @IBOutlet weak var reviewerImg: UIImageView!
    
    @IBOutlet weak var reviewerText: UILabel!
    
    @IBOutlet weak var reviewerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewerImg.layer.cornerRadius = reviewerImg.frame.height / 2
        reviewerImg.layer.masksToBounds = true
       // reviewerImg.layer.borderColor = UIColor.blue.cgColor
      //  reviewerImg.layer.borderWidth = 0.7
        reviewerImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
