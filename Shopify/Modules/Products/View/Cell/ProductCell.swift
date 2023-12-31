//
//  ProductCell.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var isFavBtn: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var produtImg: UIImageView!
    
    var delegate:ClickDelegate?
    var cellIndex: IndexPath?
    
    @IBAction func favBtnClick(_ sender: Any) {
        delegate?.clicked(cellIndex!.row)
    }
    
}
