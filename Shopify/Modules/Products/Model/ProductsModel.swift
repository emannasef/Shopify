//
//  ProductsModel.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

struct CollectionResponse: Codable {
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, bodyHTML, vendor, productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt, publishedAt: String?
    let status, publishedScope, tags, adminGraphqlAPIID: String?
    let options: [Option]?
    let images: [Image]?
    let variants: [Variant]?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case handle
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case status
        case publishedScope = "published_scope"
        case tags
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case options, images, image
        case variants
    }
}


// MARK: - Option
struct Option: Codable {
    let id, productID: Int?
    let name: String?
    let position: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, position
    }
    
}
    
    struct Variant: Codable {
        let id, productID: Int?
        let title, price, sku: String?
        let position: Int?
        let inventoryPolicy: String?
        let fulfillmentService: String?
        let option1, option2: String?
        let createdAt, updatedAt: String?
        let taxable: Bool?
        let grams: Int?
        let weight: Int?
        let weightUnit: String?
        let inventoryItemID, inventoryQuantity, oldInventoryQuantity: Int?
        let requiresShipping: Bool?
        let adminGraphqlAPIID: String?
        let presentmentPrices: [PresentmentPrice]?

        enum CodingKeys: String, CodingKey {
            case id
            case productID = "product_id"
            case title, price, sku, position
            case inventoryPolicy = "inventory_policy"
            case fulfillmentService = "fulfillment_service"
            case option1, option2
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case taxable, grams
            case weight
            case weightUnit = "weight_unit"
            case inventoryItemID = "inventory_item_id"
            case inventoryQuantity = "inventory_quantity"
            case oldInventoryQuantity = "old_inventory_quantity"
            case requiresShipping = "requires_shipping"
            case adminGraphqlAPIID = "admin_graphql_api_id"
            case presentmentPrices = "presentment_prices"
        }
    }

    // MARK: - PresentmentPrice
    struct PresentmentPrice: Codable {
        let price: Price
       

        enum CodingKeys: String, CodingKey {
            case price
          
        }
    }

    // MARK: - Price
    struct Price: Codable {
        let currencyCode, amount: String

        enum CodingKeys: String, CodingKey {
            case currencyCode = "currency_code"
            case amount
        }
    }


