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
        
        AF.request("\(baseUrl)\(endPoint.path)", method: .get, headers: header).responseJSON{ response in
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

enum BrandEndPoint{
  
    case  brands
    case products(tag:Int)
    case productPrice(tag:Int)
    case brandsProducts(tag:String)
    case allProducts
    
    var path:String{
        switch self {
        case .brands:
            return "smart_collections.json"
            
        case .products(tag: var productId):
            return "collections/\(productId)/products.json"
            
        case .productPrice(tag: let tag):
            return "products/\(tag).json"
            
        case .brandsProducts(tag: let tag):
            return "products.json?vendor=\(tag)"
        case .allProducts:
            return "/products.json"
        }
    }
}
