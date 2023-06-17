
import Foundation

struct Query: Codable {

  var amount : Int?    = nil
  var from   : String? = nil
  var to     : String? = nil

  enum CodingKeys: String, CodingKey {

    case amount = "amount"
    case from   = "from"
    case to     = "to"
  
  }



  init() {

  }

}
