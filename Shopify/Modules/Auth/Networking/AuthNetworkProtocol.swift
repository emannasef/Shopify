//
//  NetworkProtocol.swift
//  ShopifyCustomer
//
//  Created by Mac on 07/06/2023.
//

import Foundation
import Foundation
protocol AuthNetworkProtocol{
    func customerRegister(customer:Customer,compilition: @escaping(Int?,ResponseCustomer?) -> Void)
    func createWishDraftOrder(endPoint: EndPoints, model:DraftOrders, compilition: @escaping (MyDraftOrder?) -> Void)
    func updateCustomer( model:Customer, handler: @escaping (Customer?) -> Void)
}
