//
//  OrderModel.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import Foundation

// MARK: - OrderResponse
struct OrderResponse: Codable {
    let orders: [Order]?
}

// MARK: - Order
struct Order: Codable {
    let id: Int?
    let adminGraphqlAPIID: String?
    let browserIP: String?
    let buyerAcceptsMarketing: Bool?
    let cartToken: String?
    let checkoutID: Int?
    let checkoutToken: String?
    let clientDetails: ClientDetails?
    let confirmed: Bool?
    let contactEmail: String?
    let createdAt: String?
    let currency: String?
    let currentSubtotalPrice: String?
    let currentSubtotalPriceSet: OrderSet?
    let currentTotalDiscounts: String?
    let currentTotalDiscountsSet: OrderSet?
    let currentTotalPrice: String?
    let currentTotalPriceSet: OrderSet?
    let currentTotalTax: String?
    let currentTotalTaxSet: OrderSet?
    let discountCodes: [DiscountCode]?
    let email: String?
    let estimatedTaxes: Bool?
    let financialStatus: String?
    let gateway: String?
    let landingSite: String?
    let landingSiteRef: String?
    let name: String?
    let noteAttributes: [NoteAttribute]?
    let number, orderNumber: Int?
    let orderStatusURL: String?
    let paymentGatewayNames: [String]?
    let phone: String?
    let presentmentCurrency: String?
    let processedAt: String?
    let processingMethod, reference: String?
    let referringSite: String?
    let sourceIdentifier, sourceName: String?
    let subtotalPrice: String?
    let subtotalPriceSet: OrderSet?
    let tags: String?
    let taxLines: [TaxLine]?
    let taxesIncluded, test: Bool?
    let token, totalDiscounts: String?
    let totalDiscountsSet: OrderSet?
    let totalLineItemsPrice: String?
    let totalLineItemsPriceSet: OrderSet?
    let totalOutstanding, totalPrice: String?
    let totalPriceSet: OrderSet?
    let totalPriceUsd: String?
    let totalShippingPriceSet: OrderSet?
    let totalTax: String?
    let totalTaxSet: OrderSet?
    let totalTipReceived: String?
    let totalWeight: Int?
    let updatedAt: String?
    let billingAddress: Address?
    let customer: OrderCustomer?
    let discountApplications: [DiscountApplication]?
    let fulfillments: [Fulfillment]?
    let lineItems: [LineItem]?
    let paymentDetails: PaymentDetails?
    let refunds: [Refund]?
    let shippingAddress: Address?
    let shippingLines: [ShippingLine]?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case browserIP = "browser_ip"
        case buyerAcceptsMarketing = "buyer_accepts_marketing"
        case cartToken = "cart_token"
        case checkoutID = "checkout_id"
        case checkoutToken = "checkout_token"
        case clientDetails = "client_details"
        case confirmed
        case contactEmail = "contact_email"
        case createdAt = "created_at"
        case currency
        case currentSubtotalPrice = "current_subtotal_price"
        case currentSubtotalPriceSet = "current_subtotal_price_set"
        case currentTotalDiscounts = "current_total_discounts"
        case currentTotalDiscountsSet = "current_total_discounts_set"
        case currentTotalPrice = "current_total_price"
        case currentTotalPriceSet = "current_total_price_set"
        case currentTotalTax = "current_total_tax"
        case currentTotalTaxSet = "current_total_tax_set"
        case discountCodes = "discount_codes"
        case email
        case estimatedTaxes = "estimated_taxes"
        case financialStatus = "financial_status"
        case gateway
        case landingSite = "landing_site"
        case landingSiteRef = "landing_site_ref"
        case name
        case noteAttributes = "note_attributes"
        case number
        case orderNumber = "order_number"
        case orderStatusURL = "order_status_url"
        case paymentGatewayNames = "payment_gateway_names"
        case phone
        case presentmentCurrency = "presentment_currency"
        case processedAt = "processed_at"
        case processingMethod = "processing_method"
        case reference
        case referringSite = "referring_site"
        case sourceIdentifier = "source_identifier"
        case sourceName = "source_name"
        case subtotalPrice = "subtotal_price"
        case subtotalPriceSet = "subtotal_price_set"
        case tags
        case taxLines = "tax_lines"
        case taxesIncluded = "taxes_included"
        case test, token
        case totalDiscounts = "total_discounts"
        case totalDiscountsSet = "total_discounts_set"
        case totalLineItemsPrice = "total_line_items_price"
        case totalLineItemsPriceSet = "total_line_items_price_set"
        case totalOutstanding = "total_outstanding"
        case totalPrice = "total_price"
        case totalPriceSet = "total_price_set"
        case totalPriceUsd = "total_price_usd"
        case totalShippingPriceSet = "total_shipping_price_set"
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case totalTipReceived = "total_tip_received"
        case totalWeight = "total_weight"
        case updatedAt = "updated_at"
        case billingAddress = "billing_address"
        case customer
        case discountApplications = "discount_applications"
        case fulfillments
        case lineItems = "line_items"
        case paymentDetails = "payment_details"
        case refunds
        case shippingAddress = "shipping_address"
        case shippingLines = "shipping_lines"
    }
}

// MARK: - Address
struct Address: Codable {
    let firstName: String?
    let address1, phone, city, zip: String?
    let province, country: String?
    let lastName: String?
    let address2: String?
    let latitude, longitude: Double?
    let name, countryCode, provinceCode: String?
    let id, customerID: Int?
    let countryName: String?
    let addressDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case address1, phone, city, zip, province, country
        case lastName = "last_name"
        case address2, latitude, longitude, name
        case countryCode = "country_code"
        case provinceCode = "province_code"
        case id
        case customerID = "customer_id"
        case countryName = "country_name"
        case addressDefault = "default"
    }
}

// MARK: - ClientDetails
struct ClientDetails: Codable {
    let browserIP: String
    
    enum CodingKeys: String, CodingKey {
        case browserIP = "browser_ip"
    }
}

// MARK: - Set
struct OrderSet: Codable {
    let shopMoney, presentmentMoney: Money?

    enum CodingKeys: String, CodingKey {
        case shopMoney = "shop_money"
        case presentmentMoney = "presentment_money"
    }
}

// MARK: - Money
struct Money: Codable {
    let amount: String?
    let currencyCode: String?

    enum CodingKeys: String, CodingKey {
        case amount
        case currencyCode = "currency_code"
    }
}

// MARK: - Customer
struct OrderCustomer: Codable {
    let id: Int?
    let email: String?
    let acceptsMarketing: Bool?
    let createdAt, updatedAt: String?
    let firstName, lastName: String?
    let ordersCount: Int?
    let state, totalSpent: String?
    let lastOrderID: Int?
    let verifiedEmail: Bool?
    let taxExempt: Bool?
    let phone, tags: String?
    let currency: String?
    let lastOrderName: String?
    let acceptsMarketingUpdatedAt: String?
    let adminGraphqlAPIID: String?
    let defaultAddress: Address?

    enum CodingKeys: String, CodingKey {
        case id, email
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case state
        case totalSpent = "total_spent"
        case lastOrderID = "last_order_id"
        case verifiedEmail = "verified_email"
        case taxExempt = "tax_exempt"
        case phone, tags, currency
        case lastOrderName = "last_order_name"
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case defaultAddress = "default_address"
    }
}

// MARK: - DiscountApplication
struct DiscountApplication: Codable {
    let targetType, type, value, valueType: String?
    let allocationMethod, targetSelection, code: String?

    enum CodingKeys: String, CodingKey {
        case targetType = "target_type"
        case type, value
        case valueType = "value_type"
        case allocationMethod = "allocation_method"
        case targetSelection = "target_selection"
        case code
    }
}

// MARK: - DiscountCode
struct DiscountCode: Codable {
    let code, amount, type: String?
}

// MARK: - Fulfillment
struct Fulfillment: Codable {
    let id: Int?
    let adminGraphqlAPIID: String?
    let createdAt: String?
    let locationID: Int?
    let name: String?
    let orderID: Int?
    let originAddress: OriginAddress?
    let receipt: Receipt?
    let service: String?
    let status, trackingCompany, trackingNumber: String?
    let trackingNumbers: [String]?
    let trackingURL: String?
    let trackingUrls: [String]?
    let updatedAt: String?
    let lineItems: [LineItem]?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case createdAt = "created_at"
        case locationID = "location_id"
        case name
        case orderID = "order_id"
        case originAddress = "origin_address"
        case receipt, service
        case status
        case trackingCompany = "tracking_company"
        case trackingNumber = "tracking_number"
        case trackingNumbers = "tracking_numbers"
        case trackingURL = "tracking_url"
        case trackingUrls = "tracking_urls"
        case updatedAt = "updated_at"
        case lineItems = "line_items"
    }
}

// MARK: - LineItem
struct LineItem: Codable {
    let id: Int?
    let adminGraphqlAPIID: String?
    let fulfillableQuantity: Int?
    let fulfillmentService: String?
    let giftCard: Bool?
    let grams: Int?
    let name, price: String?
    let priceSet: OrderSet?
    let productExists: Bool?
    let productID: Int?
    let properties: [NoteAttribute]?
    let quantity: Int?
    let requiresShipping: Bool?
    let sku: String?
    let taxable: Bool?
    let title, totalDiscount: String?
    let totalDiscountSet: OrderSet?
    let variantID: Int?
    let variantInventoryManagement, variantTitle: String?
    let taxLines: [TaxLine]?
    let discountAllocations: [DiscountAllocation]?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case fulfillableQuantity = "fulfillable_quantity"
        case fulfillmentService = "fulfillment_service"
        case giftCard = "gift_card"
        case grams, name, price
        case priceSet = "price_set"
        case productExists = "product_exists"
        case productID = "product_id"
        case properties, quantity
        case requiresShipping = "requires_shipping"
        case sku, taxable, title
        case totalDiscount = "total_discount"
        case totalDiscountSet = "total_discount_set"
        case variantID = "variant_id"
        case variantInventoryManagement = "variant_inventory_management"
        case variantTitle = "variant_title"
        case taxLines = "tax_lines"
        case discountAllocations = "discount_allocations"
    }
}

// MARK: - DiscountAllocation
struct DiscountAllocation: Codable {
    let amount: String?
    let amountSet: OrderSet?
    let discountApplicationIndex: Int?

    enum CodingKeys: String, CodingKey {
        case amount
        case amountSet = "amount_set"
        case discountApplicationIndex = "discount_application_index"
    }
}

// MARK: - NoteAttribute
struct NoteAttribute: Codable {
    let name, value: String?
}

// MARK: - TaxLine
struct TaxLine: Codable {
    let price: String?
    let priceSet: OrderSet?
    let rate: Double?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case price
        case priceSet = "price_set"
        case rate, title
    }
}

// MARK: - OriginAddress
struct OriginAddress: Codable {
}

// MARK: - Receipt
struct Receipt: Codable {
    let testcase: Bool?
    let authorization: String?
}

// MARK: - PaymentDetails
struct PaymentDetails: Codable {
   
    let creditCardNumber, creditCardCompany: String?

    enum CodingKeys: String, CodingKey {
        case creditCardNumber = "credit_card_number"
        case creditCardCompany = "credit_card_company"
    }
}

// MARK: - Refund
struct Refund: Codable {
    let id: Int?
    let adminGraphqlAPIID: String?
    let createdAt: String?
    let note: String?
    let orderID: Int?
    let processedAt: String?
    let restock: Bool?
    let totalDutiesSet: OrderSet?
    let userID: Int?
    let transactions: [Transaction]?
    let refundLineItems: [RefundLineItem]?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case createdAt = "created_at"
        case note
        case orderID = "order_id"
        case processedAt = "processed_at"
        case restock
        case totalDutiesSet = "total_duties_set"
        case userID = "user_id"
        case transactions
        case refundLineItems = "refund_line_items"
    }
}

// MARK: - RefundLineItem
struct RefundLineItem: Codable {
    let id, lineItemID, locationID, quantity: Int?
    let restockType: String?
    let subtotal: Double?
    let subtotalSet: OrderSet?
    let totalTax: Double?
    let totalTaxSet: OrderSet?
    let lineItem: LineItem?

    enum CodingKeys: String, CodingKey {
        case id
        case lineItemID = "line_item_id"
        case locationID = "location_id"
        case quantity
        case restockType = "restock_type"
        case subtotal
        case subtotalSet = "subtotal_set"
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case lineItem = "line_item"
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let id: Int?
    let adminGraphqlAPIID, amount, authorization: String?
    let createdAt: String?
    let currency: String?
    let gateway, kind: String?
    let orderID, parentID: Int?
    let processedAt: String?
    let receipt: OriginAddress?
    let sourceName, status: String?
    let test: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case amount, authorization
        case createdAt = "created_at"
        case currency
        case gateway, kind
        case orderID = "order_id"
        case parentID = "parent_id"
        case processedAt = "processed_at"
        case receipt
        case sourceName = "source_name"
        case status, test
    }
}

// MARK: - ShippingLine
struct ShippingLine: Codable {
    let id: Int?
    let code: String?
    let discountedPrice: String?
    let discountedPriceSet: OrderSet?
    let price: String?
    let priceSet: OrderSet?
    let source, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case code
        case discountedPrice = "discounted_price"
        case discountedPriceSet = "discounted_price_set"
        case price
        case priceSet = "price_set"
        case source, title
    }
}
