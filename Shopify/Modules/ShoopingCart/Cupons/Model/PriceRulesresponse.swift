
import Foundation

struct PriceRulesresponse: Codable {

  var priceRules : [PriceRules]? = []

  enum CodingKeys: String, CodingKey {

    case priceRules = "price_rules"
  
  }


  init() {

  }

}
