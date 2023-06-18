//
//  CategoriesViewModel.swift
//  Shopify
//
//  Created by Mac on 18/06/2023.
//

import Foundation

protocol CategoriesViewModelType{
    
    var bindCategoryToViewController : (()->())? { get set }
    var bindPriceToViewController : (()->())? { get set }
    
    static func getInstatnce (network:NetworkServicing) -> CategoriesViewModelType
    func fetchProducts(tag:String,endPoint:BrandEndPoint)
    func getProductsCount() -> Int
    func getProductAtIndexPath(row:Int) -> Product
    func getProductPrice() -> String
    func fetchProductPrice(productId:Int)
    func getAccessories() -> [Product]
    func getFootWear() -> [Product]
    func getTShirts() -> [Product]
}


class CategoriesViewModel: CategoriesViewModelType{
    
    var bindPriceToViewController: (() -> ())?
    
    var bindCategoryToViewController: (() -> ())?
    var result : [Product] = []
    var price = "0"
    let network:NetworkServicing
    
    private init(network: NetworkServicing) {
        self.network = network
    }
    
    static func getInstatnce (network:NetworkServicing) -> CategoriesViewModelType {
        return CategoriesViewModel(network: network)
    }
    
    func fetchProducts(tag: String, endPoint: BrandEndPoint) {
        network.getDataOverNetwork(tag: tag, endPoint: endPoint
        ) {[weak self] (result: CollectionResponse?) in
            print(result?.products?.count)
            self?.result = result?.products ?? []
            self?.bindCategoryToViewController?()
        }
    }
    
    func getProductsCount() -> Int {
        return result.count
    }
    
    func getProductAtIndexPath(row: Int) -> Product {
        return result[row]
    }
    
    
    func getAccessories() -> [Product]{
        var accessoriesList :[Product] = []
        for item in result{
            if item.productType == "ACCESSORIES"{
                accessoriesList.append(item)
            }
                
        }
        return accessoriesList
    }
    
    func getFootWear() -> [Product] {
        var shoesList :[Product] = []
        for item in result{
            if item.productType == "SHOES"{
                shoesList.append(item)
            }
                
        }
        return shoesList
    }
    
    func getTShirts() -> [Product]{
        var tShirtsList :[Product] = []
        for item in result{
            if item.productType == "T-SHIRTS"{
                tShirtsList.append(item)
            }
        }
        return tShirtsList
    }
    
    func fetchProductPrice(productId:Int){
        network.getDataOverNetwork(tag: "", endPoint: .productPrice(tag: productId)) { (result:Product?) in
            print(result?.title)
            self.price =  result?.variants?[0].price ?? "0"
            self.bindPriceToViewController?()
        }
    }
    func getProductPrice() -> String{
        return price
    }
}
