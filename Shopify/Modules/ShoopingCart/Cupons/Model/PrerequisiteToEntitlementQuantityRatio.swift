
import Foundation

struct PrerequisiteToEntitlementQuantityRatio: Codable {

  var prerequisiteQuantity : String? = nil
  var entitledQuantity     : String? = nil

  enum CodingKeys: String, CodingKey {

    case prerequisiteQuantity = "prerequisite_quantity"
    case entitledQuantity     = "entitled_quantity"
  
  }

  init() {

  }

}
