//
//  EndPoints.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation
enum EndPoints {
    
    case updateCustomerAdress(customerId:Int,adressId:Int)
    case createCustomerAdress(id:Int)
    
    var path:String{
        switch self {
            
            
            case .createCustomerAdress(id: let customerId):
                return "customers/\(customerId)/addresses.json"
            case .updateCustomerAdress(customerId: let customerId, adressId: let adressId):
                return "\(customerId)/addresses/\(adressId).json"
        }
    }
    
}
