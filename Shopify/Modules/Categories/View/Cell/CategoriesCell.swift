//
//  CategoriesCell.swift
//  Shopify
//
//  Created by Mac on 18/06/2023.
//

import Foundation
import UIKit

class CategoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var isFav: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    
    var delegate:ClickDelegate?
    var cellIndex: IndexPath?
    
    @IBAction func favAction(_ sender: Any) {
        delegate?.clicked(cellIndex!.row)
    }
}
