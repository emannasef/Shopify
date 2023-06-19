//
//  MyCartItems.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation

class MyCartItems{
    
    static let cartItemsObjectKey = "cartItems"
    static var cartItemsCodableObject: [LineItems]? {
      get {
        return UserDefaults.standard.codableObject(dataType: [LineItems].self, key: cartItemsObjectKey)
      }
      set {
        UserDefaults.standard.setCodableObject(newValue, forKey: cartItemsObjectKey)
         // print("\(String(describing: newValue?[0].name))")
      }
    }
}
