
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
            self.creatWishList(singleCustomer: cust!)
            self.assignWishListToUser(singleCustomer: cust!.customer)
                        
        }
        
    }
    
    func setCustomerDefaults(customer:ResponseCustomer){
        UserDefaults.standard.set(customer.customer.id, forKey: "customerId")
        UserDefaults.standard.set(customer.customer.firstName, forKey: "customerName")
        UserDefaults.standard.set(customer.customer.email, forKey: "customerEmail")
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
    
    func creatWishList(singleCustomer:ResponseCustomer){
        var myDraftOrder = DraftOrders()
        myDraftOrder.note = "wish"
        myDraftOrder.customer?.id = singleCustomer.customer.id
        print("MY Customer",myDraftOrder)
        network.createWishDraftOrder(endPoint: .wishDraftOrder, model: myDraftOrder) { draftOrderRes in
            guard let myWishList = draftOrderRes?.draft_order else {
                print("draft orders empty")
                return }
            print("Drrrrrrrrraft Order Created",draftOrderRes)
            UserDefaults.standard.set(myWishList.id, forKey: "UserWishListID")
            print("WishList ID",UserDefaults.standard.string(forKey: "UserWishListID") )
        }
        
        
       
        
    }
    
    func assignWishListToUser(singleCustomer:Customer){
        guard let wishListID = UserDefaults.standard.string(forKey: "UserWishListID")  else {return}
        var customer = singleCustomer
        customer.note = wishListID
        network.updateCustomer(model:  customer) { myCust in
            let wishSpecificUser =  customer.note
            UserDefaults.standard.set(wishSpecificUser, forKey: "wishSpecificUser")
            
            print("EDITTED Customer",myCust)
        }
        
        
    }
    
  
    
}
