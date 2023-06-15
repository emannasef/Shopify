import Foundation
import Alamofire

class AdressViewModel {
    
    var adresses : [PostedAdress]?
    var addedAdress : PostedAdress!
    var bindAdressesToViewController : (() -> ())?
    var network : NetworkProtocol!
    
    
    init(network:NetworkProtocol){
        
        self.network = network
    }
    
    let headers : HTTPHeaders = [
        "Content-Type" : "application/json",
        "X-Shopify-Access-Token" : "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"]
    

    
    func getCustomerAdresses(customerId:Int){
        
        network.get(endPoint: .getCustomerAdresses(id: customerId), completionHandeler: { [weak self] (response:AllAdresses?, err) in
            
            guard let result = response else {
                print ("No response")
                return
            }
            self?.adresses = result.addresses ?? []
           // print("city...\(String(describing: self?.adresses?[0].id))")
            self!.bindAdressesToViewController!()
        })
        
    }
    

    
    func getCountOfAdress() -> Int?{
        
        return adresses?.count ?? 0
    }
    
    func addAdress(adress : UploadAdress, customerId:Int){
        
        print("add adress......")
        let params : Parameters = self.encodeToJson(objectClass: adress) ?? [:]
          network.post(endPoint: .createCustomerAdress(id: customerId), params: params){ [weak self] (postAdress:AdressResponse?, error) in
         
         guard let result = postAdress?.customer_address else{
         print(error ?? "there is an errror while posting a new adress")
         return}
         self!.addedAdress = result
         print("\(String(describing: result.city))")
         //  print("\(result.id)")
         }
        

        
    }
    
    func getDefaultAdress() -> PostedAdress{
        
        var addresses = adresses?.filter({ $0.default == true })
        
        return addresses?[0] ?? PostedAdress()
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
    
    func getAdress(index :Int) -> PostedAdress{
        
        return (adresses?[index])!
        
    }
    func updateSdress(adress : UpdatedAdressRequest ,customerId:Int){
      
        let params :Parameters = encodeToJson(objectClass: adress) ?? [:]
        network.update(endPoint: .updateAdress(customerId: customerId, adressId: adress.address?.id ?? 0), params: params) {[weak self] (postAdress:AdressResponse?, error) in
        
        guard let result = postAdress?.customer_address else{
        print(error ?? "there is an errror while updating the adress")
        return}
        print("\(String(describing: result.city))")
       
        }
        
    }
    func deleteAdress( customerId: Int, adressId: Int,address:PostedAdress){
      //  network.delete(endPoint: .deleteAdress(customerId: customerId, adressId: adressId))
        let params : Parameters = encodeToJson(objectClass: address) ?? [:]
        network.delete(endPoint: .deleteAdress(customerId: customerId, adressId: adressId), params: params)
        
    }
    func setAdressAsDefault(customerId:Int,adressId:Int){
        
        // network.update(endPoint: .setadefaultAdress(customerId: customerId, adressId: adressId), params: ["updatedAdress" : adress]) {  [weak self] (updatedAdress:Adress?, error)in
        // print("\(String(describing: updatedAdress?.default))")
    }
    
    
}





