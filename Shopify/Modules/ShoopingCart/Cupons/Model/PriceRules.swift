
import Foundation

struct PriceRules: Codable  {

  var id                                     : Int?                                    = nil
  var valueType                              : String?                                 = nil
  var value                                  : String?                                 = nil
  var customerSelection                      : String?                                 = nil
  var targetType                             : String?                                 = nil
  var targetSelection                        : String?                                 = nil
  var allocationMethod                       : String?                                 = nil
  var allocationLimit                        : String?                                 = nil
  var oncePerCustomer                        : Bool?                                   = nil
  var usageLimit                             : Int?                                    = nil
  var startsAt                               : String?                                 = nil
  var endsAt                                 : String?                                 = nil
  var createdAt                              : String?                                 = nil
  var updatedAt                              : String?                                 = nil
  var entitledProductIds                     : [String]?                               = []
  var entitledVariantIds                     : [String]?                               = []
  var entitledCollectionIds                  : [String]?                               = []
  var entitledCountryIds                     : [String]?                               = []
  var prerequisiteProductIds                 : [String]?                               = []
  var prerequisiteVariantIds                 : [String]?                               = []
  var prerequisiteCollectionIds              : [String]?                               = []
  var customerSegmentPrerequisiteIds         : [String]?                               = []
  var prerequisiteCustomerIds                : [String]?                               = []
  var prerequisiteSubtotalRange              : String?                                 = nil
  var prerequisiteQuantityRange              : String?                                 = nil
  var prerequisiteShippingPriceRange         : String?                                 = nil
  var prerequisiteToEntitlementQuantityRatio : PrerequisiteToEntitlementQuantityRatio? = PrerequisiteToEntitlementQuantityRatio()
  var prerequisiteToEntitlementPurchase      : PrerequisiteToEntitlementPurchase?      = PrerequisiteToEntitlementPurchase()
  var title                                  : String?                                 = nil
  var adminGraphqlApiId                      : String?                                 = nil

  enum CodingKeys: String, CodingKey {

    case id                                     = "id"
    case valueType                              = "value_type"
    case value                                  = "value"
    case customerSelection                      = "customer_selection"
    case targetType                             = "target_type"
    case targetSelection                        = "target_selection"
    case allocationMethod                       = "allocation_method"
    case allocationLimit                        = "allocation_limit"
    case oncePerCustomer                        = "once_per_customer"
    case usageLimit                             = "usage_limit"
    case startsAt                               = "starts_at"
    case endsAt                                 = "ends_at"
    case createdAt                              = "created_at"
    case updatedAt                              = "updated_at"
    case entitledProductIds                     = "entitled_product_ids"
    case entitledVariantIds                     = "entitled_variant_ids"
    case entitledCollectionIds                  = "entitled_collection_ids"
    case entitledCountryIds                     = "entitled_country_ids"
    case prerequisiteProductIds                 = "prerequisite_product_ids"
    case prerequisiteVariantIds                 = "prerequisite_variant_ids"
    case prerequisiteCollectionIds              = "prerequisite_collection_ids"
    case customerSegmentPrerequisiteIds         = "customer_segment_prerequisite_ids"
    case prerequisiteCustomerIds                = "prerequisite_customer_ids"
    case prerequisiteSubtotalRange              = "prerequisite_subtotal_range"
    case prerequisiteQuantityRange              = "prerequisite_quantity_range"
    case prerequisiteShippingPriceRange         = "prerequisite_shipping_price_range"
    case prerequisiteToEntitlementQuantityRatio = "prerequisite_to_entitlement_quantity_ratio"
    case prerequisiteToEntitlementPurchase      = "prerequisite_to_entitlement_purchase"
    case title                                  = "title"
    case adminGraphqlApiId                      = "admin_graphql_api_id"
  
  }


  init() {

  }

}
