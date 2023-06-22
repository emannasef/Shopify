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
    case getASingleDraftOrder(draftOrderId:Int)
    case getDraftOrder
    case getPriceRules
    case convertCurrency(to:String,from:String,amount:Double)
    case getCupons (priceRuleId:Int)
    case  brands
    case products(tag:Int)
    case productPrice(tag:Int)
    case brandsProducts(tag:String)
    case allProducts
    case orders(tag:Int)
    case postOrder
    
    case wishDraftOrder
    case updateCustomer(customerId:Int)
    case specificWish(draftId:String)
    
    
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
            
        case .brands:
            return "smart_collections.json"
            
        case .products(tag: let productId):
            return "products.json?collection_id=\(productId)"
            
        case .productPrice(tag: let tag):
            return "products/\(tag).json"
            
        case .brandsProducts(tag: let tag):
            return "products.json?vendor=\(tag)"
        case .allProducts:
            return "/products.json"
        case .orders(tag: let tag):
            return "customers/\(tag)/orders.json"
        case .postOrder:
            return "orders.json"
        case .getPriceRules:
            return "price_rules.json"
        case .getASingleDraftOrder(draftOrderId: let draftOrderId):
            return "draft_orders/\(draftOrderId).json"
            
        case .wishDraftOrder:
            return "draft_orders.json"
            
        case .updateCustomer(customerId:let customerId):
            return "customers/\(customerId).json"
            
        case .specificWish(draftId:let draftId):
            return "draft_orders/\(draftId).json"
            
        }
    }
    
}
