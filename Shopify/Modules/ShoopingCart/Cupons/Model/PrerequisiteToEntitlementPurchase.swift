
import Foundation

struct PrerequisiteToEntitlementPurchase: Codable {

  var prerequisiteAmount : String? = nil

  enum CodingKeys: String, CodingKey {

    case prerequisiteAmount = "prerequisite_amount"
  
  }

  init() {

  }

}
