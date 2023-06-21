import Foundation
import Alamofire

private let BASE_URL = "https://3c83d9abc134ed858ac39489d33e5378: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@mad43-sv-ios2.myshopify.com/admin/api/2023-04/"
private let CURRENCY_BASE_URL = "https://api.apilayer.com/currency_data/"
let headers : HTTPHeaders = [
    "Content-Type" : "application/json"]
class Network : NetworkProtocol{
    
    
    func get<T:Codable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){
        
        let path = "\(BASE_URL)\(endPoint.path)"
        
        AF.request(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { response in
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completionHandeler (jsonData,nil)
                    print("success while decoding............")
                    debugPrint(jsonData)
                } catch {
                    //print(error.localizedDescription)
                    print(String(describing: error))
                    print("error while decoding............")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("failuer while decoding............")
                completionHandeler(nil,error)
            }
        }
        
    }
    
    func getSingleDraftOrder<T:Codable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){
        
        let path = "\(BASE_URL)\(endPoint.path)"
        
        AF.request(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { response in
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completionHandeler (jsonData,nil)
                    print("success while decoding............")
                    debugPrint(jsonData)
                } catch {
                    //print(error.localizedDescription)
                    print(String(describing: error))
                    print("error while decoding............")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("failuer while decoding............")
                completionHandeler(nil,error)
            }
        }
        
    }
    
    func post<T:Codable>(endPoint: EndPoints, params: [String : Any], completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable, T : Encodable {
        
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpShouldHandleCookies = false
        
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
            
        }catch let error{
            debugPrint(error.localizedDescription)
        }
        
        AF.request(request).responseJSON { response in
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: response.data ?? Data()) as? [String: Any] else {
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
                print(prettyPrintedJson)
                print("-------------------------")
                
                
                guard let responseData = response.data else{return}
                print("responseData: \(responseData)")
                print("-------------------------")
                let result = try JSONDecoder().decode(T.self, from: responseData)
                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print("from catch")
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    func update<T>(endPoint: EndPoints, params: [String : Any], completionHandeler: @escaping ((T?), Error?) -> Void) where T : Decodable, T : Encodable {

        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        request.httpShouldHandleCookies = false
        
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("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", forHTTPHeaderField: "X-Shopify-Access-Token")
            
        }catch let error{
            debugPrint(error.localizedDescription)
        }
        
        AF.request(request).responseJSON { response in
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: response.data ?? Data()) as? [String: Any] else {
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
                print(prettyPrintedJson)
                print("-------------------------")
                
                
                guard let responseData = response.data else{return}
                print("responseData: \(responseData)")
                print("-------------------------")
                let result = try JSONDecoder().decode(T.self, from: responseData)
                
                completionHandeler(result, nil)
                
            }catch let error
            {
                completionHandeler(nil, error)
                print("from catch")
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    func delete(endPoint: EndPoints,params: [String : Any]) {
        let path = "\(BASE_URL)\(endPoint.path)"
        
        let headers: HTTPHeaders = ["content-type": "Application/json"]
        AF.request(path, method: .delete, parameters: params,headers: headers ).responseData { response in
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
                    
                    print("succefully deleted.....")
                    // print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print("from  catch...")
                print(error)
            }
        }
        
    }
    
    
    func convertCurrencyget <T:Codable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){
   
            let path = "\(CURRENCY_BASE_URL)\(endPoint.path)"
            let headers : HTTPHeaders = [
            "apikey" : "8mGJZxjbWYaEXpKbAkp1CuPgN2m9OtQD"]
            
            AF.request(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseData { response in
                switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completionHandeler (jsonData,nil)
                        print("success while decoding............")
                        debugPrint(jsonData)
                    } catch {
                        //print(error.localizedDescription)
                        print(String(describing: error))
                        print("error while decoding............")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("failuer while decoding............")
                    completionHandeler(nil,error)
                }
            }
            
        }
        
    }
    



  
    
    

