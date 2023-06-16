//
//  ProductInfoViewModel.swift
//  ShopifyCustomer
//
//  Created by Mac on 11/06/2023.
//

import Foundation
import Alamofire
class ProductInfoViewModel{
    
    var bindingProductInfo:(()->()) = {}


    var product : ProductInfo? {
        didSet {
            bindingProductInfo()
        }
    }
    
    var network:NetworkProtocol!
    init(network: NetworkProtocol!) {
        self.network = network
    }
    
    
    func getProductDetails(productId:Int){
        
        network.get(endPoint: .productDetails(id: productId)) {  [weak self] (retrivedProduct:ProductInfo?, err) in
            self?.product = retrivedProduct
        }
        
    }
    
   /* func addToCart(customerId:Int){
        
        let params : Parameters = encodeToJson(objectClass: self.product) ?? [:]
        network.post(endPoint: .createCustomerAdress(id: customerId), params: params) { (response:DraftOrderResponse?, error )in
            <#code#>
        }
    }*/
    
}
