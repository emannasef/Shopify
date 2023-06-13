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

