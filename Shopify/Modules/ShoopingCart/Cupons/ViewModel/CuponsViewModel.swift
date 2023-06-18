
import Foundation

class CuponsViewModel {
    var cupons : [Discount]?
    var network : NetworkProtocol!
    var bindToViewController :(()->())?
    
    init (network:NetworkProtocol){
        self.network = network
    }
    
    func getCupons(priceruleId:Int){
        network.get(endPoint: .getCupons(priceRuleId: priceruleId),completionHandeler:  { (response:DiscountsResponse?, error) in
            guard response != nil else {
                print ("No response")
                return
            }
            self.cupons = response?.discount_codes
            self.bindToViewController!()
            
        })
    }
    
    func getCountOfCupons()-> Int{
        return cupons?.count ?? 0
    }
    
    func getASingleCupon(index:Int)->Discount{
        return cupons?[index] ?? Discount()
    }
    
}


