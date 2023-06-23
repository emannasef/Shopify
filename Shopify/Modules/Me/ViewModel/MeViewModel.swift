//
//  MeViewModel.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import Foundation

protocol MeViewModelType{
    var bindOrdersToViewController : (()->())? { get set }
    static func getInstatnce (network:NetworkServicing) -> MeViewModelType
    func fetchOrders(tag:String,endPoint:EndPoints)
    func getOrderAtIndexPath(row:Int) -> Order
    func getCustomerId() -> Int
    func getOrdersCount() -> Int
}
class MeViewModel:MeViewModelType{
  
   
    var bindOrdersToViewController: (() -> ())?
    var result : [Order] = []
    let network:NetworkServicing
    
    private init(network: NetworkServicing) {
        self.network = network
    }
    
    static func getInstatnce (network:NetworkServicing) -> MeViewModelType {
        return MeViewModel(network: network)
    }
    
    func fetchOrders(tag: String, endPoint: EndPoints) {
        network.getDataOverNetwork(tag: tag, endPoint: endPoint) {[weak self] (result:OrderResponse?) in
            self?.result = result?.orders ?? []
            self?.bindOrdersToViewController?()
            print(result?.orders?.count)
        }
    }
    
    
    func getOrderAtIndexPath(row: Int) -> Order {
        result[row]
    }
    
    func getOrdersCount() -> Int {
        result.count
    }
    
    func getCustomerId() -> Int {
        let userId  = Int( UserDefaults.standard.string(forKey: "customerId") ?? "0") ?? 0
        print("===============user id \(userId)")
        return userId
    }
    
}
