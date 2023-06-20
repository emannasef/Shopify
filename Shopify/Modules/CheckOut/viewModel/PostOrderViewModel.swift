//
//  PostOrderViewModel.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import Foundation

protocol PotOrderViewModelType{
    func postOrder(endpoint:EndPoints,params:[String:Any])
    func getUserId()-> Int
    func getCartProducts()-> [Product]
    func getDiscountCode()-> Int
}
class PostOrderViewModel : PotOrderViewModelType{
    
    var network : NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func postOrder(endpoint:EndPoints,params:[String:Any]) {
        network.post(endPoint: endpoint, params: params) {[weak self] (postOrder:PostOrder?, error) in
            guard let result = postOrder?.order else{
            print(error ?? "there is an errror while posting a order")
            print(error?.localizedDescription)
            print(String(describing: error))
            return}
        }
    }
    
    func getUserId() -> Int {
        let userId  = Int( UserDefaults.standard.string(forKey: "customerId") ?? "0") ?? 0
        return userId
    }
    
    func getCartProducts() -> [Product] {
        let lintItems : [Product] = []
        
        return lintItems
    }
    
    func getDiscountCode() -> Int {
        return 1234
    }
    
   
}