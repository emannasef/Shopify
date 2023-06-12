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
    
    func addAdress(adress : Adress, customerId:Int){
        
        print("add adress......")
        
        network.post(endPoint: .createCustomerAdress(id: customerId), params: ["addedAdress" : adress]){ [weak self] (postAdress:Adress?, error) in
            
            guard let result = postAdress else{
                print(error ?? "there is an errror while posting a new adress")
                return}
            self!.addedAdress = result
            print("\(String(describing: result.city))")
            //  print("\(result.id)")
        }
        
    }
    
    func getAdress(index :Int) -> Adress{
        
        return (adresses?[index])!
        
    }
    func updateSdress(adress : Adress , index :Int){
        // network.get(endPoint: ., completionHandeler: T##(((Decodable & Encodable)?), Error?) -> Void)
        
    }

    func setAdressAsDefault(adress:Adress){
       // LocalDefaultAdress.adressCodableObject = adress
        //print("\(String(describing: LocalDefaultAdress.adressCodableObject?.name))")
        
        
    }
    

}


