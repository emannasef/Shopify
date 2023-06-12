//
//  AdressViewModel2.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

class AdressViewModel {
    
   // var adresses : [Adress]!
    var adresses = [Adress(address1: "6 O October", city: "Cairo", name: "Manal Hamada", country: "Egypt", zip: "1234", phone: "0123456789"),Adress(address1: "6 O October", city: "Cairo", name: "Manal Hamada", country: "Egypt", zip: "1234", phone: "0123456789")]
    var addedAdress : Adress!
    var binddressesToViewController : () ->() = {}
    var network : NetworkProtocol!

    
    init(network:NetworkProtocol){
        
        self.network = network
    }
    
   
    func getCountOfAdress() -> Int?{
        
        return adresses.count
    }
    
    func addAdress(adress : Adress){
        
        print("ad adress......")
        
      /*  network.post(endPoint: .createCustomerAdress(id: 207119551), params: ["addedAdress" : adress]){ postAdress, error in
            
            guard let result = postAdress else{
                print(error ?? "there is an errror while posting a new adress")
                return}
            self.addedAdress = result
            print("\(result.city)")
          //  print("\(result.id)")
        }*/
        
    }
    
    func getAdress(index :Int) -> Adress{
        
        return (adresses[index])
        
    }
    func updateSdress(adress : Adress , index :Int){
       // network.update(endPoint: <#T##EndPoints#>, params: <#T##[String : Any]#>, completionHandeler: <#T##(((Decodable & Encodable)?), Error?) -> Void#>)
        
    }
    
    func addAdressAsDefault(adress:Adress){
        
        LocalDefaultAdress.adressCodableObject = adress
        
        print("\(String(describing: LocalDefaultAdress.adressCodableObject?.name))")
    }
    
    func getDefaultAdress() -> Adress{
        
        return LocalDefaultAdress.adressCodableObject ?? Adress()
    }
}

