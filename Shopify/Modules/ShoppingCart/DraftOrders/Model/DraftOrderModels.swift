import Foundation

struct DraftOrderResponse: Codable {

  var draftOrders : [DraftOrders]? = []

  enum CodingKeys: String, CodingKey {

    case draftOrders = "draft_orders"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    draftOrders = try values.decodeIfPresent([DraftOrders].self , forKey: .draftOrders )
 
  }

  init() {

  }

}

struct DraftOrders: Codable {

  var id                : Int?             = nil
  var note              : String?          = nil
  var email             : String?          = nil
  var name              : String?          = nil
  var totalPrice        : String?          = nil
  var taxesIncluded     : Bool?            = nil
  var currency          : String?          = nil
  var createdAt         : String?          = nil
  var updatedAt         : String?          = nil
  var taxExempt         : Bool?            = nil
  var completedAt       : String?          = nil
  var lineItems         : [LineItems]?     = []
  var shippingAddress   : ShippingAddress? = ShippingAddress()
  var invoiceUrl        : String?          = nil
  var appliedDiscount   : String?          = nil
  var orderId           : Int?             = nil
  var taxLines          : [TaxLines]?        = []
  var tags              : String?          = nil
  var subtotalPrice     : String?          = nil
  var totalTax          : String?          = nil
  var customer          : Customer?        = Customer()

  enum CodingKeys: String, CodingKey {

    case id                = "id"
    case note              = "note"
    case email             = "email"
    case name              = "name"
    case totalPrice        = "total_price"
    case taxesIncluded     = "taxes_included"
    case currency          = "currency"
    case createdAt         = "created_at"
    case updatedAt         = "updated_at"
    case taxExempt         = "tax_exempt"
    case completedAt       = "completed_at"
    case lineItems         = "line_items"
    case shippingAddress   = "shipping_address"
    case invoiceUrl        = "invoice_url"
    case appliedDiscount   = "applied_discount"
    case orderId           = "order_id"
    case taxLines          = "tax_lines"
    case tags              = "tags"
    case subtotalPrice     = "subtotal_price"
    case totalTax          = "total_tax"
    case customer          = "customer"
  
  }

  init() {

  }

}

struct TaxLines: Codable {
    
    var rate  : Double? = nil
    var title : String? = nil
    var price : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case rate  = "rate"
        case title = "title"
        case price = "price"
        
    }
    
    
    
    init() {
        
    }
}

struct BillingAddress: Codable {

  var firstName    : String? = nil
  var address1     : String? = nil
  var phone        : String? = nil
  var city         : String? = nil
  var zip          : String? = nil
  var province     : String? = nil
  var country      : String? = nil
  var lastName     : String? = nil
  var address2     : String? = nil
  var company      : String? = nil
  var latitude     : Double? = nil
  var longitude    : Double? = nil
  var name         : String? = nil
  var countryCode  : String? = nil
  var provinceCode : String? = nil

  enum CodingKeys: String, CodingKey {

    case firstName    = "first_name"
    case address1     = "address1"
    case phone        = "phone"
    case city         = "city"
    case zip          = "zip"
    case province     = "province"
    case country      = "country"
    case lastName     = "last_name"
    case address2     = "address2"
    case company      = "company"
    case latitude     = "latitude"
    case longitude    = "longitude"
    case name         = "name"
    case countryCode  = "country_code"
    case provinceCode = "province_code"
  
  }


  init() {

  }

}


struct ShippingAddress: Codable {

  var firstName    : String? = nil
  var address1     : String? = nil
  var phone        : String? = nil
  var city         : String? = nil
  var zip          : String? = nil
  var province     : String? = nil
  var country      : String? = nil
  var lastName     : String? = nil
  var address2     : String? = nil
  var company      : String? = nil
  var latitude     : Double? = nil
  var longitude    : Double? = nil
  var name         : String? = nil
  var countryCode  : String? = nil
  var provinceCode : String? = nil

  enum CodingKeys: String, CodingKey {

    case firstName    = "first_name"
    case address1     = "address1"
    case phone        = "phone"
    case city         = "city"
    case zip          = "zip"
    case province     = "province"
    case country      = "country"
    case lastName     = "last_name"
    case address2     = "address2"
    case company      = "company"
    case latitude     = "latitude"
    case longitude    = "longitude"
    case name         = "name"
    case countryCode  = "country_code"
    case provinceCode = "province_code"
  
  }


  init() {

  }

}


struct Customer: Codable {

  var id                        : Int?            = nil
  var email                     : String?         = nil
  var acceptsMarketing          : Bool?           = nil
  var createdAt                 : String?         = nil
  var updatedAt                 : String?         = nil
  var firstName                 : String?         = nil
  var lastName                  : String?         = nil
  var ordersCount               : Int?            = nil
  var state                     : String?         = nil
  var totalSpent                : String?         = nil
  var lastOrderId               : Int?            = nil
  var note                      : String?         = nil
  var verifiedEmail             : Bool?           = nil
  var multipassIdentifier       : String?         = nil
  var taxExempt                 : Bool?           = nil
  var phone                     : String?         = nil
  var tags                      : String?         = nil
  var lastOrderName             : String?         = nil
  var currency                  : String?         = nil
  var acceptsMarketingUpdatedAt : String?         = nil
  var marketingOptInLevel       : String?         = nil
  var taxExemptions             : [String]?       = []
  var adminGraphqlApiId         : String?         = nil
  var defaultAddress            : DefaultAddress? = DefaultAddress()

  enum CodingKeys: String, CodingKey {

    case id                        = "id"
    case email                     = "email"
    case acceptsMarketing          = "accepts_marketing"
    case createdAt                 = "created_at"
    case updatedAt                 = "updated_at"
    case firstName                 = "first_name"
    case lastName                  = "last_name"
    case ordersCount               = "orders_count"
    case state                     = "state"
    case totalSpent                = "total_spent"
    case lastOrderId               = "last_order_id"
    case note                      = "note"
    case verifiedEmail             = "verified_email"
    case multipassIdentifier       = "multipass_identifier"
    case taxExempt                 = "tax_exempt"
    case phone                     = "phone"
    case tags                      = "tags"
    case lastOrderName             = "last_order_name"
    case currency                  = "currency"
    case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
    case marketingOptInLevel       = "marketing_opt_in_level"
    case taxExemptions             = "tax_exemptions"
    case adminGraphqlApiId         = "admin_graphql_api_id"
    case defaultAddress            = "default_address"
  
  }



  init() {

  }

}


struct LineItems: Codable {

  var variantId          : Int?      = nil
  var productId          : Int?      = nil
  var title              : String?   = nil
  var variantTitle       : String?   = nil
  var sku                : String?   = nil
  var vendor             : String?   = nil
  var quantity           : Int?      = nil
  var requiresShipping   : Bool?     = nil
  var taxable            : Bool?     = nil
  var giftCard           : Bool?     = nil
  var fulfillmentService : String?   = nil
  var grams              : Int?      = nil
  var taxLines           : [TaxLines]? = []
  var appliedDiscount    : String?   = nil
  var name               : String?   = nil
  var properties         : [Properties]? = []
  var custom             : Bool?     = nil
  var price              : String?   = nil
  var adminGraphqlApiId  : String?   = nil

  enum CodingKeys: String, CodingKey {

    case variantId          = "variant_id"
    case productId          = "product_id"
    case title              = "title"
    case variantTitle       = "variant_title"
    case sku                = "sku"
    case vendor             = "vendor"
    case quantity           = "quantity"
    case requiresShipping   = "requires_shipping"
    case taxable            = "taxable"
    case giftCard           = "gift_card"
    case fulfillmentService = "fulfillment_service"
    case grams              = "grams"
    case taxLines           = "tax_lines"
    case appliedDiscount    = "applied_discount"
    case name               = "name"
    case properties         = "properties"
    case custom             = "custom"
    case price              = "price"
    case adminGraphqlApiId  = "admin_graphql_api_id"
  
  }


  init() {

  }

}
struct Properties: Codable {

  var name  : String? = nil
  var value : String? = nil
  var color : String? = nil
  var size : String? = nil

  enum CodingKeys: String, CodingKey {

    case name  = "name"
    case value = "value"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name  = try values.decodeIfPresent(String.self , forKey: .name  )
    value = try values.decodeIfPresent(String.self , forKey: .value )
 
  }

  init() {

  }

}


struct DefaultAddress: Codable {

  var id           : Int?    = nil
  var customerId   : Int?    = nil
  var firstName    : String? = nil
  var lastName     : String? = nil
  var company      : String? = nil
  var address1     : String? = nil
  var address2     : String? = nil
  var city         : String? = nil
  var province     : String? = nil
  var country      : String? = nil
  var zip          : String? = nil
  var phone        : String? = nil
  var name         : String? = nil
  var provinceCode : String? = nil
  var countryCode  : String? = nil
  var countryName  : String? = nil
  var `default`      : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case id           = "id"
    case customerId   = "customer_id"
    case firstName    = "first_name"
    case lastName     = "last_name"
    case company      = "company"
    case address1     = "address1"
    case address2     = "address2"
    case city         = "city"
    case province     = "province"
    case country      = "country"
    case zip          = "zip"
    case phone        = "phone"
    case name         = "name"
    case provinceCode = "province_code"
    case countryCode  = "country_code"
    case countryName  = "country_name"
    case `default`    = "default"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
    customerId   = try values.decodeIfPresent(Int.self    , forKey: .customerId   )
    firstName    = try values.decodeIfPresent(String.self , forKey: .firstName    )
    lastName     = try values.decodeIfPresent(String.self , forKey: .lastName     )
    company      = try values.decodeIfPresent(String.self , forKey: .company      )
    address1     = try values.decodeIfPresent(String.self , forKey: .address1     )
    address2     = try values.decodeIfPresent(String.self , forKey: .address2     )
    city         = try values.decodeIfPresent(String.self , forKey: .city         )
    province     = try values.decodeIfPresent(String.self , forKey: .province     )
    country      = try values.decodeIfPresent(String.self , forKey: .country      )
    zip          = try values.decodeIfPresent(String.self , forKey: .zip          )
    phone        = try values.decodeIfPresent(String.self , forKey: .phone        )
    name         = try values.decodeIfPresent(String.self , forKey: .name         )
    provinceCode = try values.decodeIfPresent(String.self , forKey: .provinceCode )
    countryCode  = try values.decodeIfPresent(String.self , forKey: .countryCode  )
    countryName  = try values.decodeIfPresent(String.self , forKey: .countryName  )
    `default`      = try values.decodeIfPresent(Bool.self   , forKey: .default      )
 
  }

  init() {

  }

}


