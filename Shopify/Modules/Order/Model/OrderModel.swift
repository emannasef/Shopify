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

struct PostOrder : Codable{
    var order: Order?
}

// MARK: - Order
class Order: Codable {
    var id: Int? = nil
    var admin_graphql_api_id: String? = nil
    var confirmed: Bool? = nil
    var contact_email: String? = nil
    var created_at: String?  = nil
    var currency: String? = nil
    var current_subtotal_price: String? = nil
    var current_subtotal_priceSet: OrderSet? = nil
    var current_total_discounts: String? = nil
    var current_total_price: String? = nil
    var current_total_price_set: OrderSet? = nil
    var current_total_tax: String? = nil
    var current_total_tax_set: OrderSet? = nil
    var discount_codes: [DiscountCode]? = nil
    var email: String? = nil
    var estimated_taxes: Bool? = nil
    var financial_status: String? = nil
    var gateway: String? = nil
    var name: String? = nil
    var note_attributes: [NoteAttribute]? = nil
    var number: Int? = nil
    var order_number: Int? = nil
    var order_status_uRL: String? = nil
    var payment_gateway_names: [String]? = nil
    var presentment_currency: String? = nil
    var processed_at: String? = nil
    var processing_method: String? = nil
    var subtotal_price: String? = nil
    var subtotal_price_set: OrderSet? = nil
    var tags: String? = nil
    var tax_lines: [TaxLine]? = nil
    var taxes_included: Bool? = nil
    var test: Bool? = nil
    var token: String? = nil
    var total_discounts: String? = nil
    var total_discounts_set: OrderSet? = nil
    var total_line_items_price: String? = nil
    var total_line_items_price_set: OrderSet? = nil
    var totalOutstanding: String? = nil
    var total_price: String? = nil
    var totalPriceSet: OrderSet? = nil
    var totalPriceUsd: String? = nil
    var totalShippingPriceSet: OrderSet? = nil
    var updatedAt: String? = nil
    var customer: OrderCustomer? = nil
    var discountApplications: [DiscountApplication]? = nil
    var fulfillments: [Fulfillment]? = nil
    var line_items: [LineItems]? = nil
    var payment_details: PaymentDetails? = nil
    var refunds: [Refund]? = nil
    var shipping_address: PostedAdress? = nil
    var shippingLines: [ShippingLine]? = nil

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
    var id: Int?
    var email: String?
    var accepts_marketing: Bool?
    var created_at, updated_at: String?
    var first_name, last_name: String?
    var orders_count: Int?
    var state, total_spent: String?
    var last_order_id: Int?
    var verified_email: Bool?
    var tax_exempt: Bool?
    var phone, tags: String?
    var currency: String?
    var last_order_name: String?
    var accepts_marketing_updated_at: String?
    var admin_graphqlapi_id: String?
    var default_address: PostedAdress?

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
    let lineItems: [LineItems]?

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
   
    let credit_card_number, credit_card_company: String?

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
    let lineItem: LineItems?

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
