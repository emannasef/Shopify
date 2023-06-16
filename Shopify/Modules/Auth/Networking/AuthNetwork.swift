//
//  Network.swift
//  ShopifyCustomer
//
//  Created by Mac on 07/06/2023.
//

import Foundation
import Alamofire
class AuthNetwork : AuthNetworkProtocol{

    
    let headers : HTTPHeaders = [
          "Content-Type" : "application/json",
          "X-Shopify-Access-Token" : "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"]
    
    
    func customerRegister(customer:Customer,compilition: @escaping(Int?,ResponseCustomer?) -> Void ) {

            let params: Parameters =  ["customer": ["first_name": customer.firstName,
                                                    "email": customer.email,
                                                    "tags": customer.tags
                                                   ]]

           let url = "https://3c83d9abc134ed858ac39489d33e5378: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@mad43-sv-ios2.myshopify.com/admin/api/2023-04/customers.json"


        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData{ response in
            
                switch response.result {
                    case .success(let data):

                        do {
                                let jsonData = try JSONDecoder().decode(ResponseCustomer.self, from: data)
                                debugPrint(jsonData)
                                compilition(response.response?.statusCode,jsonData)
                          
                        } catch {
                            print("Error: Trying to convert JSON data to string")
                            return
                        }


                    case .failure(let error):
                        print(error)
                }
            }

        
        }
    
    
//    func allCustomers(complition: @escaping ((MyCustomer?), Error?) -> Void) {
//
//
//        let url = "https://3c83d9abc134ed858ac39489d33e5378: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@mad43-sv-ios2.myshopify.com/admin/api/2023-04/customers.json"
//
//
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
//            switch response.result{
//                case .success(let data):
//                  do{
//                      let jsonData = try JSONDecoder().decode(MyCustomer.self, from: data)
//                      complition(jsonData,nil)
//                     // debugPrint(jsonData)
//                 } catch {
//                    print(error.localizedDescription)
//                 }
//               case .failure(let error):
//                 print(error.localizedDescription)
//                complition(nil,error)
//               }
//          }
//
//    }
    
    
    
}
