//
//  EndPints.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

enum EndPoints {
    
    case allCustomer
    case productDetails(id: Int)
    case updateCustomerAdress(customerId:Int,adressId:Int)
    case createCustomerAdress(id:Int)
    case getCustomerAdresses(id:Int)
    case setadefaultAdress(customerId:Int , adressId:Int)
    case deleteAdress(customerId:Int , adressId:Int)
    case updateAdress(customerId:Int , adressId:Int)
    case createDraftOrder
    case modifieDraftOrder(draftOrderId:Int)
    case deleteDraftOrder(draftOrderId:Int)
    case getDraftOrder
    case convertCurrency(to:String,from:String,amount:Double)
    case getCupons (priceRuleId:Int)
    
    
    var path:String{
        switch self {
        case .allCustomer:
            return "customers.json"
        case .productDetails(id: let productId):
            return "products/\(productId).json"
        case .createCustomerAdress(id: let customerId):
            return "customers/\(customerId)/addresses.json"
        case .updateCustomerAdress(customerId: let customerId, adressId: let adressId):
            return "\(customerId)/addresses/\(adressId).json"
        case .getCustomerAdresses(id: let customerId):
            return "customers/\(customerId)/addresses.json"
        case .setadefaultAdress(customerId: let customerId, adressId: let adressId):
            return "customers/\(customerId)/addresses/\(adressId)/default.json"
        case .deleteAdress(customerId: let customerId, adressId: let adressId):
            return "customers/\(customerId)/addresses/\(adressId).json"
        case .getDraftOrder:
            return "draft_orders.json"
        case .updateAdress(customerId: let customerId, adressId: let adressId):
            return "customers/\(customerId)/addresses/\(adressId).json"
        case .createDraftOrder:
           return "draft_orders.json"
        case .modifieDraftOrder(draftOrderId: let draftOrderId):
            return "draft_orders/\(draftOrderId).json"
        case .deleteDraftOrder(draftOrderId: let draftOrderId):
            return "draft_orders/\(draftOrderId).json"
        case .convertCurrency(to: let to, from: let from ,amount: let amount):
            return "convert?to=\(to)&from=\(from)&amount=\(amount)"
        case .getCupons(priceRuleId: let priceRuleId):
            return "price_rules/\(priceRuleId)/discount_codes.json"
        }
    }
    
}
