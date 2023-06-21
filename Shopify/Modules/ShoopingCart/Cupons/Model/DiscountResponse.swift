
import Foundation


var discountsArr : [AdsAttachedData]?

struct DiscountsResponse : Codable{
   
    var discount_codes : [Discount]!
  
  
    
}

struct Discount : Codable{
    
    var id : Int = 0
    var price_rule_id : Int = 0
    var code : String = ""
    var usage_count :Int = 0
    var created_at : String = ""
    var updated_at : String = ""
        
    init(){
        
    }
}

