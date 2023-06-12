//
//  NetworkManager.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation
import Alamofire

protocol NetworkServicing{
    
    func getDataOverNetwork<T:Decodable>(tag :String,endPoint : BrandEndPoint, compilitionHandler: @escaping (T?) -> Void)
    
}

class NetworkManager : NetworkServicing{
    
    
    var baseUrl = "https://mad43-sv-ios2.myshopify.com/admin/api/2023-04/"
    
    func getDataOverNetwork<T:Decodable>(tag :String,endPoint : BrandEndPoint, compilitionHandler: @escaping (T?) -> Void)
    {
        
        let header: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request("\(baseUrl)\(endPoint.rawValue)", method: .get, headers: header).responseJSON{ response in
            print(response)
            do{
                let result = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                debugPrint(result)
                compilitionHandler(result)
            }catch let error {
                print("Network error")
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }
    }
    
    
    
}

enum BrandEndPoint: String {
    case  brands = "smart_collections.json"
}
