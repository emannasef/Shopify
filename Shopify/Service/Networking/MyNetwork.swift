//
//  Network.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

import Alamofire


private let BASE_URL = "https://3c83d9abc134ed858ac39489d33e5378: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@mad43-sv-ios2.myshopify.com/admin/api/2023-04/"

let headers : HTTPHeaders = [
      "Content-Type" : "application/json",
      "X-Shopify-Access-Token" : "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"]


class MyNetwork : MyNetworkProtocol{
     func get<T:Codable>(endPoint: MyEndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){

        let path = "\(BASE_URL)\(endPoint.path)"

         AF.request(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { response in
             switch response.result{
                 case .success(let data):
                   do{
                       let jsonData = try JSONDecoder().decode(T.self, from: data)
                       completionHandeler (jsonData,nil)
                    debugPrint(jsonData)
                  } catch {
                     print(error.localizedDescription)
                      print(String(describing: error))
                  }
                case .failure(let error):
                  print(error.localizedDescription)
                 completionHandeler(nil,error)
                }
           }

    }
}
