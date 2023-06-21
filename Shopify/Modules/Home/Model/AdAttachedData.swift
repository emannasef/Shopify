
import Foundation

struct AdsAttachedData{
    
    var status :String?
    var discount :Discount?
    
    init(status:String,discount:Discount){
        
        self.status = status
        self.discount = discount
    }
    
    
}
