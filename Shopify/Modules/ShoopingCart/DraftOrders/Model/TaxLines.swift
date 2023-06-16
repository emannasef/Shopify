//
//  TaxLines.swift
//  Shopify
//
//  Created by Mac on 15/06/2023.
//

import Foundation


struct TaxLines: Codable {
    
    var rate  : Double? = nil
    var title : String? = nil
    var price : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case rate  = "rate"
        case title = "title"
        case price = "price"
        
    }
    
    
    
    init() {
        
    }
}
