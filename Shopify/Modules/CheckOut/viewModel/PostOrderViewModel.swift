//
//  PostOrderViewModel.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import Foundation

protocol PostOrderViewModelType{
    func postOrder(endpoint:EndPoints,params:[String:Any])
    func getUserId()-> Int
    func getLineItems()-> [LineItems]
    func getDiscountCode()-> Int
    var myError : Error? { get  }
    var bindPostresponse: (()->())? { get set }
}
class PostOrderViewModel : PostOrderViewModelType{
    var bindPostresponse: (() -> ())?
    
    var network : NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    var myError : Error?
    var result : Order?
    
    func postOrder(endpoint:EndPoints,params:[String:Any]) {
        network.post(endPoint: endpoint, params: params) {[weak self] (postOrder:PostOrder?, error) in
            guard let result = postOrder?.order
            else{
            print(error ?? "there is an errror while posting a order")
            print(error?.localizedDescription)
                self?.myError = error
            print(String(describing: error))
            return}
            self?.result = result
            self?.bindPostresponse?()
        }
    }
    
    func getUserId() -> Int {
        let userId  = Int( UserDefaults.standard.string(forKey: "customerId") ?? "0") ?? 0
        return userId
    }
    
    func getLineItems() -> [LineItems] {
        let lintItems : [LineItems] = MyCartItems.cartItemsCodableObject ?? []
        return lintItems
    }
    
    func getDiscountCode() -> Int {
        return 1234
    }
    
   
}
