
import Foundation

struct Info: Codable {

  var quote     : Double? = nil
  var timestamp : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case quote     = "quote"
    case timestamp = "timestamp"
  
  }



  init() {

  }

}
