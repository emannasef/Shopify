//
//  Adress.swift
//  ShopifyCustomer
//
//  Created by Mac on 10/06/2023.
//

import Foundation
struct AllAdresses : Codable{
    
    var addresses : [Adress]?
}

struct PostedAdress:Codable{
    
    var  address1: String?
    var  address2: String?
    var  city: String?
    var  company: String?
    var  first_name: String?
    var  last_name: String?
    var  phone: String?
    var  province: String?
    var  country: String?
    var  zip: String?
    var  name: String?
    var  province_code: String?
    var  country_code: String?
    var  country_name: String?
  
    enum CodingKeys: String, CodingKey {

        case  address1 =  "address1"
        case  address2 =  "address2"
        case  city =  "city"
        case  company =  "company"
        case  first_name =  "first_name"
        case  last_name =  "last_name"
        case  phone =  "phone"
        case  province =  "province"
        case  country =  "country"
        case  zip =  "zip"
        case  name =  "name"
        case  province_code =  "province_code"
        case  country_code =  "country_code"
        case  country_name =  "country_name"
   
     
    
    }
    init(name:String ,city:String,region:String){
        self.name = name
        self.city = city
        self.address1 = region
        
    }
    }

struct Adress: Codable,Equatable {

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
      case `default`      = "default"
  
  }

    init(name:String,city:String,region:String){
       
        self.city = city
        self.address1 = region
        self.name = name
    }
    
   
    
/*  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
    customerId   = try values.decodeIfPresent(Int.self    , forKey: .customerId   )
    firstName    = try values.decodeIfPresent(String.self , forKey: .firstName    )
    lastName     = try values.decodeIfPresent(String.self , forKey: .lastName     )
    company      = try values.decodeIfPresent(String.self , forKey: .company      )
    address1     = try values.decodeIfPresent(String.self , forKey: .address1     )
    address2     = try values.decodeIfPresent(String.self , forKey: .address2     )
    city         = try values.decodeIfPresent(String.self , forKey: .city         )
    province     = try values.decodeIfPresent(String.self , forKey: .province     )
    country      = try values.decodeIfPresent(String.self , forKey: .country      )
    zip          = try values.decodeIfPresent(String.self , forKey: .zip          )
    phone        = try values.decodeIfPresent(String.self , forKey: .phone        )
    name         = try values.decodeIfPresent(String.self , forKey: .name         )
    provinceCode = try values.decodeIfPresent(String.self , forKey: .provinceCode )
    countryCode  = try values.decodeIfPresent(String.self , forKey: .countryCode  )
    countryName  = try values.decodeIfPresent(String.self , forKey: .countryName  )
    default default = try values.decodeIfPresent(Bool.self   , forKey: .default      )
 
  }*/

  init() {

  }

}


////
///

