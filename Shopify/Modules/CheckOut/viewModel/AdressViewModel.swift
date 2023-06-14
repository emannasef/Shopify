import Foundation
import Alamofire
class AdressViewModel {
    
    var adresses : [Adress]?
    var addedAdress : Adress!
    var bindAdressesToViewController : (() -> ())?
    var network : NetworkProtocol!
    
    
    init(network:NetworkProtocol){
        
        self.network = network
    }
    
    func getCustomerAdresses(customerId:Int){
        
        network.get(endPoint: .getCustomerAdresses(id: customerId), completionHandeler: { [weak self] (response:AllAdresses?, err) in
            
            guard let result = response else {
                print ("No response")
                return
            }
            self?.adresses = result.addresses ?? []
            print("city...\(String(describing: self?.adresses?[0].id))")
            self!.bindAdressesToViewController!()
        })
        
    }
    
    
    func getCountOfAdress() -> Int?{
        
        return adresses?.count ?? 0
    }
    
    func addAdress(adress : PostedAdress, customerId:Int){
        
        print("add adress......")
        let params = self.encodeToJson(objectClass: adress) ?? [:]
        
        network.post(endPoint: .createCustomerAdress(id: customerId), params: params){ [weak self] (postAdress:Adress?, error) in
            
            guard let result = postAdress else{
                print(error ?? "there is an errror while posting a new adress")
                return}
            self!.addedAdress = result
            print("\(String(describing: result.city))")
            //  print("\(result.id)")
        }
        
    }
    
    func encodeToJson<T: Codable>(objectClass: T) -> [String: Any]?{
            do{
                let jsonData = try JSONEncoder().encode(objectClass)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)!
                return jsonToDictionary(from: json)
            }catch let error{
                print(error.localizedDescription)
                return nil
            }
        }
        
        func jsonToDictionary(from text: String) -> [String: Any]? {
            guard let data = text.data(using: .utf8) else { return nil }
            let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
            return anyResult as? [String : Any]
        }
    
    func getAdress(index :Int) -> Adress{
        
        return (adresses?[index])!
        
    }
    func updateSdress(adress : Adress , index :Int){
        // network.get(endPoint: ., completionHandeler: T##(((Decodable & Encodable)?), Error?) -> Void)
        
    }
    func deleteAdress( customerId: Int, adressId: Int){
        network.delete(endPoint: .deleteAdress(customerId: customerId, adressId: adressId))
        
    }
    func setAdressAsDefault(customerId:Int,adressId:Int){
      
       // network.update(endPoint: .setadefaultAdress(customerId: customerId, adressId: adressId), params: ["updatedAdress" : adress]) {  [weak self] (updatedAdress:Adress?, error)in
           // print("\(String(describing: updatedAdress?.default))")
        }
        
        
    }
    




