//
//  HomeModels.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

struct BrandsResponse: Codable {
    let smartCollections: [SmartCollections]?
    private enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
}
struct SmartCollections: Codable {

    let id: Int
    let handle: String
    let title: String
    let updatedAt: String
    let bodyHtml: String
    let publishedAt: String
    let sortOrder: String
    let templateSuffix: String?
    let disjunctive: Bool
    let rules: [Rules]
    let publishedScope: String
    let adminGraphqlApiId: String
    let image: Image

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case handle = "handle"
        case title = "title"
        case updatedAt = "updated_at"
        case bodyHtml = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case disjunctive = "disjunctive"
        case rules = "rules"
        case publishedScope = "published_scope"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case image = "image"
    }

}


struct Rules: Codable {

    let column: String
    let relation: String
    let condition: String

    private enum CodingKeys: String, CodingKey {
        case column = "column"
        case relation = "relation"
        case condition = "condition"
    }

}

struct Image: Codable {
    
    let id: Int?
    let productId: Int?
    let position: Int?
    let createdAt: String?
    let updatedAt: String?
    let alt: String?
    let width: Int?
    let height: Int?
    let src: String?
    let adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case position = "position"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alt = "alt"
        case width = "width"
        case height = "height"
        case src = "src"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}

