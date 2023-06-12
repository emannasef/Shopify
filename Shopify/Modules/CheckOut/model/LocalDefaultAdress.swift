import Foundation

class LocalDefaultAdress{
    
    static let adressObjectKey = "adressObjectKey"
    static var adressCodableObject: Adress? {
      get {
        return UserDefaults.standard.codableObject(dataType: Adress.self, key: adressObjectKey)
      }
      set {
        UserDefaults.standard.setCodableObject(newValue, forKey: adressObjectKey)
          print("\(newValue?.name)")
      }
    }
}
