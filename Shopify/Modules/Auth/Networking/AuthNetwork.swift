//
//  Network.swift
//  ShopifyCustomer
//
//  Created by Mac on 07/06/2023.
//

import Foundation
import Alamofire
class AuthNetwork : AuthNetworkProtocol{

    private let BASE_URL = "https://3c83d9abc134ed858ac39489d33e5378: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@mad43-sv-ios2.myshopify.com/admin/api/2023-04/"
    
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
    
    
    func createWishDraftOrder(endPoint: EndPoints, model:DraftOrders, compilition: @escaping (MyDraftOrder?) -> Void) {
        let myParams: Parameters = [
                      "draft_order": [
                        "note": model.note ,
                          "line_items": [
                            [
                                  "title": "dummy for fav",
                                  "price": "1000",
                                  "quantity": 1
                              ]
                              
                          ],
                          "customer": [
                            "id": model.customer?.id
                          ],
                          "use_customer_default_address": true
                      ]
                  ]

        let url = "\(BASE_URL)\(endPoint.path)"

    print("create URl",url)
    AF.request(url, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: headers).responseData{ response in
        
            switch response.result {
                case .success(let data):

                    do {
                            let jsonData = try JSONDecoder().decode(MyDraftOrder.self, from: data)
                           // debugPrint("In Debug Print",jsonData)
                            compilition(jsonData)
                      
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }


                case .failure(let error):
                print(error)
              
                compilition(nil)
            }
        }
    }
    
    
    func updateCustomer( model:Customer, handler: @escaping (Customer?) -> Void) {
        let myParams: Parameters =
        [
            "customer": [
              "note": model.note
            ]
        ]
        let url = "\(BASE_URL)customers/\(model.id!).json"
        
        print("Updaeded URL",url)
        AF.request(url, method: .put, parameters:myParams , encoding: JSONEncoding.default, headers:headers)
                .validate(statusCode: 200 ..< 299).responseData { response in
                  switch response.result {
                  case .success(let data):
                    do {
                      guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                      }
                      guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                      }
                      guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                      }
                        debugPrint(prettyPrintedJson)
                        let result = try JSONDecoder().decode(Customer.self,from: data)
                        handler(result)
                        print("draft custumer: \(result)")
                    } catch {
                        handler(nil)
                        print("Error: Trying to convert JSON data to string")
                      return
                    }
                  case .failure(let error):
                      handler(nil)
                      print("FFFFaaaaaluuuuuure")
                      print(String(describing: error))
                    
                  }
                }
          }
    
}
