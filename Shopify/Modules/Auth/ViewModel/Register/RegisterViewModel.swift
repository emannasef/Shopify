
//
//  RegisterViewModel.swift
//  ShopifyCustomer
//
//  Created by Mac on 07/06/2023.
//

import Foundation


class RegisterViewModel{
    
   // var customer:Customer
    
    var bindingSignUp:(()->())?
    
    var statusCode : Int? {
        didSet {
            bindingSignUp!()
        }
    }
    
    
    var network:NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    
    
    func registerCustomer(customer:Customer){
        network.customerRegister(customer: customer) { check in
            self.statusCode = check
        }
        
//        UserDefaults.standard.set(customer.id, forKey: "customerId")
//        UserDefaults.standard.set(customer.first_name, forKey: "customerName")
//        UserDefaults.standard.set(true, forKey: "isLogin")
//        let userDefultId =  UserDefaults.standard.integer(forKey:"customerId")
//            print("Id is", userDefultId ?? 0)
        
    }
    

    
}
