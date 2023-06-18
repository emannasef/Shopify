
import Foundation


protocol CurrencyViewModel {
    var bindResultToviewController : (()->())? { get set }
}

class SettingsViewModel : CurrencyViewModel{
    
    var result : Double!
    var bindResultToviewController : (()->())?
    var network:NetworkProtocol!
    
    
    init (network:NetworkProtocol){
        self.network = network
    }
    
    func convertCurrency(to:String,from:String,amount:String){
        
        network.convertCurrencyget(endPoint: .convertCurrency(to: to, from: from, amount: Double(amount) ?? 0.0), completionHandeler: { [weak self] (response:CurrencyResponse?, err) in
            
            guard let result = response else {
                print ("No response")
                return
            }
            self?.result = result.result
            self!.bindResultToviewController!()
        })
        
        
    }
}
