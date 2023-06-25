//
//  OrderProductsCell.swift
//  Shopify
//
//  Created by Mac on 20/06/2023.
//

import UIKit

class OrderProductsCell: UICollectionViewCell {
    @IBOutlet weak var isFav: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    var delegate:ClickDelegate?
    var cellIndex: IndexPath?
    
    @IBAction func favBtnClick(_ sender: Any) {
        delegate?.clicked(cellIndex!.row)
    }
    
    
}
