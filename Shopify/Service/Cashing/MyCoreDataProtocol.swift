//
//  MyCoreDataProtocol.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation
protocol MyCorDataProtocol {
    func insertFavProduct(product: FavProduct)
    func getStoredProducts() -> [FavProduct]
    func deleteFavProduct(product : FavProduct)
    func isProductExist(product : FavProduct) -> Bool
    
}
