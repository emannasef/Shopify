//
//  Adress.swift
//  ShopifyCustomer
//
//  Created by Mac on 10/06/2023.
//

import Foundation

struct Adress : Codable {
    var id : Int?
    var address1 : String?
    var city : String?
    var name : String?
    var country : String?
    var zip : String?
    var phone : String?
    
    
    init(address1 : String,city : String,name : String,country : String,zip : String,phone : String) {
        self.address1 = address1
        self.city = city
        self.name = name
        self.country = country
        self.zip = zip
        self.phone = phone
    }
    
    
    init (){
        
    }
   /* var id : Int?
    var customer_id:Int?
    var first_name: String?
    var last_name: String?
    var company: String?
    var address1 : String?
    var address2 : String?
    var city :  String?
    var province : String?
    var country: String?
    var zip: String?
    var phone: String?
    var name: String?
    var province_code: String?
    var country_code: String?
    var country_name: String?
    var _default: Bool
     
     
     init(address1 : String,city : String,name : String,country : String,zip : String,phone : String) {
         self.address1 = address1
         self.city = city
         self.name = name
         self.country = country
         self.zip = zip
         self.phone = phone
     }
     
     init(){
         
     }
    */
}
