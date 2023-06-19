//
//  AppUserDefaults.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation

let defaults = UserDefaults.standard



func setProductId(productId:Int){
    
    defaults.setValue(productId, forKey: "productId")

}

func getProductId() ->Int{
   return defaults.integer(forKey: "productId")
}


func setDraftOrderId(draftOrderId:Int){
    
    defaults.setValue(draftOrderId, forKey: "draftOrdertId")

}

func getDraftOrdertId()-> Int{
    defaults.integer(forKey: "draftOrdertId")
}

func setScreenMode(mode:Int){
    
    defaults.setValue(mode, forKey: "mode")

}

func getScreenMode()-> Int{
    defaults.integer(forKey: "mode")
}

func getCurrency() ->String{
    return defaults.string(forKey: "currency") ?? "USD"
}

func setCurrency(currency:String){
    
    defaults.setValue(currency, forKey: "currency")

}


extension UserDefaults{
    func setCodableObject<T: Codable>(_ data: T?, forKey cartItems: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: cartItems)
    }
    
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
