//
//  DefaultAdress.swift
//  Shopify
//
//  Created by Mac on 15/06/2023.
//

import Foundation
struct DefaultAddress: Codable {

  var id           : Int?    = nil
  var customerId   : Int?    = nil
  var firstName    : String? = nil
  var lastName     : String? = nil
  var company      : String? = nil
  var address1     : String? = nil
  var address2     : String? = nil
  var city         : String? = nil
  var province     : String? = nil
  var country      : String? = nil
  var zip          : String? = nil
  var phone        : String? = nil
  var name         : String? = nil
  var provinceCode : String? = nil
  var countryCode  : String? = nil
  var countryName  : String? = nil
  var `default`      : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case id           = "id"
    case customerId   = "customer_id"
    case firstName    = "first_name"
    case lastName     = "last_name"
    case company      = "company"
    case address1     = "address1"
    case address2     = "address2"
    case city         = "city"
    case province     = "province"
    case country      = "country"
    case zip          = "zip"
    case phone        = "phone"
    case name         = "name"
    case provinceCode = "province_code"
    case countryCode  = "country_code"
    case countryName  = "country_name"
    case `default`    = "default"
  
  }


  init() {

  }

}
