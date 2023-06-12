//
//  NetworkProtocol.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

protocol NetworkProtocol{
    
    func get<T:Codable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
 //   func get<T: Decodable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
    
   func post<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
    func post(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((Adress?), Error?) -> Void)
    
    func update<T: Codable>(endPoint: EndPoints, params: [String: Any], completionHandeler: @escaping ((T?), Error?) -> Void)
    
    func delete(endPoint: EndPoints)
    
}
