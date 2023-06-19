//
//  OrderViewModel.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import Foundation
protocol OrderViewModelType{
    var bindOrdersToViewController : (()->())? { get set }
    static func getInstatnce (network:NetworkServicing) -> OrderViewModelType
    func fetchOrders(tag:String,endPoint:BrandEndPoint)
    func getOrdersCount()->Int
    func getOrderAtIndexPath(row:Int) -> Order
}

class OrderViewModel : OrderViewModelType{
  
    var bindOrdersToViewController: (() -> ())?
    var result : [Order] = []
    let network:NetworkServicing
    
    private init(network: NetworkServicing) {
        self.network = network
    }
    
    static func getInstatnce (network:NetworkServicing) -> OrderViewModelType {
        return OrderViewModel(network: network)
    }
    
    func fetchOrders(tag: String, endPoint: BrandEndPoint) {
        network.getDataOverNetwork(tag: tag, endPoint: endPoint) {[weak self] (result:OrderResponse?) in
            self?.result = result?.orders ?? []
            self?.bindOrdersToViewController?()
            print(result?.orders?.count)
        }
    }
    
    func getOrdersCount() -> Int {
        result.count
    }
    
    func getOrderAtIndexPath(row: Int) -> Order {
        result[row]
    }
    
    
    
}
