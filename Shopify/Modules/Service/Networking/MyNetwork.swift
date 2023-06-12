
import Foundation
import Alamofire

//private let BASE_URL = "https://3c83d9abc134ed858ac39489d33e5378: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@mad43-sv-ios2.myshopify.com/admin/api/2023-04/"
private let BASE_URL = "https://mad43-sv-ios2.myshopify.com/admin/api/2023-04/"

class Network : NetworkProtocol{
    
    func get<T>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable {
        
        let path = "\(BASE_URL)\(endPoint.path)"

        AF.request(path).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print(error.localizedDescription)
                print("\(error)")
            }
        }
        
    }
    
    func post<T>(endPoint: EndPoints, params: [String : Any], completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable, T : Encodable {
        let path = "\(BASE_URL)\(endPoint.path)"

        let headers: HTTPHeaders = ["X-Shopify-Access-Token": "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",
                                    "Content-Type": "application/json"]

        
        AF.request(path,method: .post,parameters: params,headers: headers).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print(error.localizedDescription)
            }
        }
    }
    
    func update<T>(endPoint: EndPoints, params: [String : Any], completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable, T : Encodable {
        let path = "\(BASE_URL)\(endPoint.path)"

        let headers: HTTPHeaders = ["content-type": "Application/json"]
        
        AF.request(path,method: .put,parameters: params,headers: headers).responseJSON { response in
            do{
                guard let responseData = response.data else{return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print(error.localizedDescription)
            }
        }
        
    }
    
    func delete(endPoint: EndPoints) {
        let path = "\(BASE_URL)\(endPoint.path)"

        let headers: HTTPHeaders = ["content-type": "Application/json"]
        
        AF.request(path,method: .delete,headers: headers).responseJSON { response in
            guard let responseData = response.data else{return}
            print(responseData)
        }
    }
    
}
