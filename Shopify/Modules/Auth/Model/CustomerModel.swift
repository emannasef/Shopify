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

struct Customer:Codable {
    var id:Int?
    var first_name:String?
    var last_name:String?
    var email:String?
    var tags:String?
}

struct ResponseCustomer:Codable{
    var customer:Customer
}
