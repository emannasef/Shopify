
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
            self.setCustomerDefaults(customer: cust!)
            
        }
        
    }
    
    func setCustomerDefaults(customer:ResponseCustomer){
        UserDefaults.standard.set(customer.customer.id, forKey: "customerId")
        UserDefaults.standard.set(customer.customer.firstName, forKey: "customerName")
        UserDefaults.standard.set(customer.customer.email, forKey: "customerEmail")
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
  
    
}
