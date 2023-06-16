//
//  AppUserDefaults.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//
import Foundation
import UIKit
import Toast

func createToastMessage(message:String , view:UIView){
    
    var style = ToastStyle()
    style.messageColor = UIColor.white
    style.backgroundColor = UIColor(named: "AccentColor") ?? UIColor.blue
    style.activitySize = CGSize(width: 200.0, height: 20.0)
    view.makeToast(message, duration: 3.0, position: .center, style: style)
}

/*extension UserDefaults{
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
      let encoded = try? JSONEncoder().encode(data)
      set(encoded, forKey: defaultName)
    }
    
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
      guard let userDefaultData = data(forKey: key) else {
        return nil
      }
      return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
    
    // Usage:
   /let key = "foo_key"
    let codableObject = CodableObject(value: 100)
    UserDefaults.standard.setCodableObject(codableObject, forKey: key)
    
    // Usage:
    let key = "foo_key"
    if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: CodableObject.self, key: key) {
      print("\(retrievedCodableObject.value)")
    } else {
      print("Not yet saved with key \(key)")
    }
}*/
