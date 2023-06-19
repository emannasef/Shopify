
import Foundation

var currencies = ["AED","AUD","CAD","CHF","CZK","DKK","EUR","GBP", "HKD","ILS","JPY","KRW","MYR","NZD","PLN","SEK","SGD","USD"]

struct CurrencyResponse: Codable {

  var date       : String? = nil
  var historical : Bool?   = nil
  var info       : Info?   = Info()
  var query      : Query?  = Query()
  var result     : Double? = nil
  var success    : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case date       = "date"
    case historical = "historical"
    case info       = "info"
    case query      = "query"
    case result     = "result"
    case success    = "success"
  
  }



  init() {

  }

}
