//
//  AppUserDefaults.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//
import Foundation

extension UserDefaults{
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
   /* let key = "foo_key"
    let codableObject = CodableObject(value: 100)
    UserDefaults.standard.setCodableObject(codableObject, forKey: key)
    
    // Usage:
    let key = "foo_key"
    if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: CodableObject.self, key: key) {
      print("\(retrievedCodableObject.value)")
    } else {
      print("Not yet saved with key \(key)")
    }*/
}
