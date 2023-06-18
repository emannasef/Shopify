//
//  ProductsViewModel.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

protocol ProductsViewModelType{
    
    var bindProductsToViewController : (()->())? { get set }
    
    static func getInstatnce (network:NetworkServicing) -> ProductsViewModelType
    func fetchProducts(tag:String,endPoint:BrandEndPoint)
    func getProductsCount() -> Int
    func getProductAtIndexPath(row:Int) -> Product
    var result : [Product] { get set }
    
}




class ProductsViewModel: ProductsViewModelType{
    
    var bindProductsToViewController: (() -> ())?
    var result : [Product] = []
    let network:NetworkServicing
    
    private init(network: NetworkServicing) {
        self.network = network
    }
    
    static func getInstatnce(network: NetworkServicing) -> ProductsViewModelType {
        return ProductsViewModel(network: network)
    }
    
    func fetchProducts(tag: String, endPoint: BrandEndPoint){
        network.getDataOverNetwork(tag: tag, endPoint: endPoint
        ) {[weak self] (result: CollectionResponse?) in
           // print(result?.products?.count)
            self?.result = result?.products ?? []
            self?.bindProductsToViewController?()
        }
    }
    
    func getProductsCount() -> Int {
        return result.count
    }
    
    func getProductAtIndexPath(row: Int) -> Product {
        return result[row]
    }
    
    

}



class AllProducts {
    
    var bindAllProductsToView : (()->()) = {}
    
    var res :[Product]! {
        didSet{
            bindAllProductsToView()
        }
    }
    
    let network:NetworkServicing
   
    
    init(network: NetworkServicing) {
        self.network = network
    }
    
    func getAllProducts(){
        network.getDataOverNetwork(tag: "", endPoint: .allProducts
        ) {[weak self] (result: CollectionResponse?) in
            self?.res = result?.products
                    }
    }
    
}
