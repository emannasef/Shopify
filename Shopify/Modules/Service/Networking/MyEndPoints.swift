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
    case getCustomerAdresses(id:Int)
    case setadefaultAdress(customerId:Int , adressId:Int)
    
    var path:String{
        switch self {
            
            
            case .createCustomerAdress(id: let customerId):
                return "customers/\(customerId)/addresses.json"
            case .updateCustomerAdress(customerId: let customerId, adressId: let adressId):
                return "\(customerId)/addresses/\(adressId).json"
        case .getCustomerAdresses(id: let customerId):
            return "customers/\(customerId)/addresses.json"
        case .setadefaultAdress(customerId: let customerId, adressId: let adressId):
            return "customers/\(customerId)/addresses/\(adressId)/default.json.json"
        }
    }
    
}
