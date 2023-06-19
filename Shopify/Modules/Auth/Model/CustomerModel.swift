//
//  CustomerModel.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation


struct MyCustomer:Codable{
    var customers:[Customer]
}


struct Customer: Codable {

  var id                        : Int?            = nil
  var email                     : String?         = nil
  var acceptsMarketing          : Bool?           = nil
  var createdAt                 : String?         = nil
  var updatedAt                 : String?         = nil
  var firstName                 : String?         = nil
  var lastName                  : String?         = nil
  var ordersCount               : Int?            = nil
  var state                     : String?         = nil
  var totalSpent                : String?         = nil
  var lastOrderId               : Int?            = nil
  var note                      : String?         = nil
  var verifiedEmail             : Bool?           = nil
  var multipassIdentifier       : String?         = nil
  var taxExempt                 : Bool?           = nil
  var phone                     : String?         = nil
  var tags                      : String?         = nil
  var lastOrderName             : String?         = nil
  var currency                  : String?         = nil
  var acceptsMarketingUpdatedAt : String?         = nil
  var marketingOptInLevel       : String?         = nil
  var taxExemptions             : [String]?       = []
  var adminGraphqlApiId         : String?         = nil
  var defaultAddress            : DefaultAddress? = DefaultAddress()

  enum CodingKeys: String, CodingKey {

    case id                        = "id"
    case email                     = "email"
    case acceptsMarketing          = "accepts_marketing"
    case createdAt                 = "created_at"
    case updatedAt                 = "updated_at"
    case firstName                 = "first_name"
    case lastName                  = "last_name"
    case ordersCount               = "orders_count"
    case state                     = "state"
    case totalSpent                = "total_spent"
    case lastOrderId               = "last_order_id"
    case note                      = "note"
    case verifiedEmail             = "verified_email"
    case multipassIdentifier       = "multipass_identifier"
    case taxExempt                 = "tax_exempt"
    case phone                     = "phone"
    case tags                      = "tags"
    case lastOrderName             = "last_order_name"
    case currency                  = "currency"
    case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
    case marketingOptInLevel       = "marketing_opt_in_level"
    case taxExemptions             = "tax_exemptions"
    case adminGraphqlApiId         = "admin_graphql_api_id"
    case defaultAddress            = "default_address"
  
  }


    init(id:Int){
        self.id = id
    }

  init() {

  }

}

struct ResponseCustomer:Codable{
    var customer:Customer
}
