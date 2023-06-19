
import Foundation
class LoginViewModel{
    
    var network:NetworkProtocol!
    
    init(network: NetworkProtocol!) {
        self.network = network
    }
    
    var bindingLogin:(()->()) = {}
    
    var customerLogin : MyCustomer? {
        didSet {
            bindingLogin()
        }
    }
    
    func getCustomer(){
        network.get(endPoint: .allCustomer) { [weak self] (retrivecustomer:MyCustomer?, err) in
            self?.customerLogin = retrivecustomer
        }
        
    }
    
    func vaildateCustomer(customerEmail:String,customerPasssword:String)->Int{
        var isVailed = 0

        if let myCustomerLogin = customerLogin {
            
            print(myCustomerLogin.customers.count)
            for i in 0..<(myCustomerLogin.customers.count){
                if customerEmail == myCustomerLogin.customers[i].email && customerPasssword == myCustomerLogin.customers[i].tags{
                    UserDefaults.standard.set(myCustomerLogin.customers[i].id, forKey: "customerId")
                    UserDefaults.standard.set(myCustomerLogin.customers[i].firstName, forKey: "customerName")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    isVailed = 1
                    return isVailed
                }
               else if customerEmail != myCustomerLogin.customers[i].email && customerPasssword == myCustomerLogin.customers[i].tags{
                 isVailed = 2
                }
                else if customerEmail == myCustomerLogin.customers[i].email && customerPasssword != myCustomerLogin.customers[i].tags{
                 isVailed = 3
                }
        }
          
        }
        return isVailed


    }

    
    
}
