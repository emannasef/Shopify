//
//  NetworkProtocol.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation
protocol MyNetworkProtocol{
   func get<T: Codable>(endPoint: MyEndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
    
 func post<T: Codable>(endPoint: MyEndPoints,  params: [String : Any] ,completionHandeler: @escaping ((T?), Error?) -> Void)
}
