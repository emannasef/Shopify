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
   // func allCustomers(complition:@escaping ((MyCustomer?),Error?) -> Void)
}
