//
//  OrderDetailsViewController.swift
//  Shopify
//
//  Created by Mac on 20/06/2023.
//

import UIKit
import Kingfisher

class OrderDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var itemsCollection: UICollectionView!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var paymentMethods: UILabel!
    
    @IBOutlet weak var paymentText: UILabel!
    var order:Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orderTitle.text = order.name ?? "My Order"
        orderNumber.text = String(format:"%d",order.order_number ?? 1)
        address.text = order.customer?.default_address?.city
        totalPrice.text = order.total_price ?? "100"
        //paymentMethods.text = order.payment_details?.credit_card_company ?? "cash"
        paymentText.isHidden = true
        orderDate.text = DateFormate(orderDate: order.processed_at ?? "3-11-2000" )
       
        
        let nib = UINib(nibName: "OrderProductsCell", bundle: nil)
        itemsCollection.register(nib, forCellWithReuseIdentifier: "orderProductCell")
        
        itemsCollection.dataSource = self
        itemsCollection.delegate = self
        
       
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return order.line_items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollection.dequeueReusableCell(withReuseIdentifier: "orderProductCell", for: indexPath) as! OrderProductsCell
        
        cell.productName.text = order.line_items?[indexPath.row].title
        cell.productImage.kf.setImage(
            with: URL(string: order.line_items?[indexPath.row].properties?[0].value ?? ""),
            placeholder: UIImage(named: "brandplaceholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        cell.productPrice.text = order.line_items?[indexPath.row].price
        
        cell.isFav.isHidden = true
        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 3
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 232)
    }
}
