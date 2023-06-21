//
//  MyCartItems.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation

class MyCartItems{
    
    static let cartItemsObjectKey = "cartItems"
    static let discountArrayKey = "cartItems"
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

class MyDiscountArray{

    static let discountArrayKey = "discountArray"
    static var discountArrayCodableObject: [AdsAttachedData]{
      get {
          return UserDefaults.standard.codableObject(dataType: [AdsAttachedData].self, key: discountArrayKey) ?? []
      }
      set {
        UserDefaults.standard.setCodableObject(newValue, forKey: discountArrayKey)
         // print("\(String(describing: newValue?[0].name))")
      }
    }
}
