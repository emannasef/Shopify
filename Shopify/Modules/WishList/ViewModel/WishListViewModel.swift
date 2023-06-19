//
//  WishListViewModel.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation
class WishListViewModel {
    
    var myCoreData:MyCorDataProtocol!
  
    var bindResultToView : (()->()) = {}
    
    var favArray:[FavProduct]!
    
    init( myCoreData: MyCorDataProtocol!) {
        
        self.myCoreData = myCoreData
    }
    
    func getSoredFavs() -> [FavProduct]{
      let userId  =  UserDefaults.standard.string(forKey: "customerId")
        return myCoreData.getStoredProducts(userId: "\(String(describing: userId))")
    }

    func deleteFavProduct(product:FavProduct){
        myCoreData.deleteFavProduct(product: product)
    }
    
    
    func insertFavProduct(product:FavProduct){
        myCoreData.insertFavProduct(product: product)
    }
    
    func isProductExist(product:FavProduct)->Bool{
        return myCoreData.isProductExist(product: product)
    }
    
}
