//
//  WishListCell.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import UIKit

class WishListCell: UICollectionViewCell {
    
    @IBOutlet weak var wishListImage: UIImageView!
    @IBOutlet weak var wishListPrice: UILabel!
    @IBOutlet weak var wishListTitle: UILabel!
    
    var delegate:ClickDelegate?
    var cellIndex: IndexPath?
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.clicked(cellIndex!.row)
    }
    
    
}
