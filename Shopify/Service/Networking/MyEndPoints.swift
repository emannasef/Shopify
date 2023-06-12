//
//  EndPints.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

enum MyEndPoints {
    
    case allCustomer
    case productDetails(id: Int)
    
    
    var path:String{
        switch self {
        case .allCustomer:
            return "customers.json"
        case .productDetails(id: let productId):
            return "products/\(productId).json"
        }
    }
    
}
