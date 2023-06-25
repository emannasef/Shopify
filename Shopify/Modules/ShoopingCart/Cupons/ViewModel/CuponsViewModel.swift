
import Foundation

class CuponsViewModel {
    var cupons : [Discount]?
    var priceRules : [PriceRules]?
    var totalCupons : [Discount]? = []
    var priceRuleIdes : [Int]?
    var network : NetworkProtocol!
    var bindToViewController :(()->())?
    var bindPricerulesToViewControllers :(()->())?
    var discount : Discount? = Discount()
    init (network:NetworkProtocol){
        self.network = network
    }
    
    func getCupons(priceruleId:Int){
            network.get(endPoint: .getCupons(priceRuleId: priceruleId),completionHandeler:  { (response:DiscountsResponse?, error) in
                guard response != nil else {
                    print ("No response")
                    return}
                    
                    self.cupons = response?.discount_codes
                    self.totalCupons! += self.cupons ?? []
                   // print("dISCOUNT CODE  \(String(describing: self.totalCupons?[0].code))")
                    self.bindToViewController!()
                
            })
    }
    
    func getCountOfCupons()-> Int{
        return cupons?.count ?? 0
    }
    
    func getASingleCupon(index:Int)->Discount{
        return cupons?[index] ?? Discount()
    }
    
    func getPriceRules(){
        
        network.get(endPoint: .getPriceRules,completionHandeler: { (response:PriceRulesresponse?, error) in
            guard response != nil else {return}
            self.priceRules = self.filterPriceRules(priceRules: response?.priceRules ?? [])
            self.bindPricerulesToViewControllers!()
            
        })
    }
    
    
    
    func filterPriceRules(priceRules:[PriceRules]) -> [PriceRules]{
        
        let priceRules = priceRules.filter { $0.valueType == "percentage"}
        
        self.priceRuleIdes = priceRules.map({ priceRule in
            priceRule.id ?? 0
        })
         
        return priceRules
    }
    
    func setSelectedDiscount(discount:Discount){
       
    }
    func getSelectedDiscount() -> Discount{
        return discount ?? Discount()
    }
}


