
//
//  RegisterViewModel.swift
//  ShopifyCustomer
//
//  Created by Mac on 07/06/2023.
//

import Foundation


class RegisterViewModel{
    
    var bindingSignUp:(()->())?
    
    var statusCode : Int? {
        didSet {
            bindingSignUp!()
        }
    }
    
    
    var network:AuthNetworkProtocol
    
    init(network: AuthNetworkProtocol) {
        self.network = network
    }
    
    
    
    func registerCustomer(customer:Customer){
        network.customerRegister(customer: customer) { check, cust in
            self.statusCode = check
            // print("######",cust)
            UserDefaults.standard.set(cust?.customer.id, forKey: "customerId")
            UserDefaults.standard.set(cust?.customer.firstName, forKey: "customerName")
            UserDefaults.standard.set(cust?.customer.email, forKey: "customerEmail")
            UserDefaults.standard.set(true, forKey: "isLogin")
            let userDefultId =  UserDefaults.standard.integer(forKey:"customerId")
                                    print("Id is", userDefultId ?? 0)
            
            print("Name",UserDefaults.standard.string(forKey: "customerName"))
        }
        
        
        
//        network.post(endPoint: .allCustomer, params: <#T##[String : Any]#>, completionHandeler: <#T##(((Decodable & Encodable)?), Error?) -> Void#>)
        
    }
    
  
    
}
