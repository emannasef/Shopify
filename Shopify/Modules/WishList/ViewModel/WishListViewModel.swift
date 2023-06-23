//
//  WishListViewModel.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation
import Alamofire
class WishListViewModel {
    
    var myCoreData:MyCorDataProtocol!
    var network:NetworkProtocol!
  
    
    var favArray:[FavProduct]!
    
    init( myCoreData: MyCorDataProtocol!,network:NetworkProtocol) {
        self.myCoreData = myCoreData
        self.network = network
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
    
    
 //   ------------------------- Network -------------
    
    var lineItemsArr:[LineItems] = []
    
    var bindingData : (()->()) = {}
    
    var allLineItemsArr:[LineItems]? {
        didSet {
            bindingData()
        }
    }
    
    func getWishList(Draftid:String){
        network.get(endPoint: .specificWish(draftId: Draftid)){ (response:MyDraftOrder?, error )in
            guard let result = response?.draft_order else{return}
            print("user Draft order",result)
            print(response ?? "")
            self.allLineItemsArr = response?.draft_order?.lineItems ?? []
            print("My Addedd Lines",self.allLineItemsArr ?? [])
        }
    }
    
    func insertLineItem(draftOrdrId:String,product:Product){
        
        let params : Parameters = encodeToJson(objectClass: createADraftOrder(draftOrdrId: draftOrdrId, product: product)) ?? [:]
        
        network.update(endPoint: .specificWish(draftId: draftOrdrId), params: params) { (response:MyDraftOrder?, error )in
            guard let result = response?.draft_order else{
                print(error ?? "there is an errror while adding a new item to your cart")
                return}
            self.lineItemsArr = result.lineItems!
            
            print("User Line Items",result.lineItems ?? "")
        }
    }
    
    func addItem(product:Product){
        let proVarient = product.variants?[0]
        let variantId = proVarient?.id
        let title = product.title
        let variTitle = proVarient?.title
        let price = proVarient?.price
        let properties = [Properties(name: "url_image", value: product.images?[0].src ?? "")]
        let item = LineItems(variantId: variantId ?? 0, title: title ?? "", varientTitle: variTitle ?? "", price: price ?? "", properties: properties, quantity: 1)
        
        lineItemsArr.append(item)
        
    }
    
    func createADraftOrder(draftOrdrId:String,product:Product) -> MyDraftOrder{
        addItem(product: product)
        return createWishOrder(draftOrderId: Int(draftOrdrId) ?? 0, lineItems: lineItemsArr )
        
    }
    
    
    func createWishOrder (draftOrderId:Int,lineItems:[LineItems]) ->MyDraftOrder{
        let draftOrder = DraftOrders(id: draftOrderId,lineItems: lineItems,note: "wish")
        let myDraftOrder = MyDraftOrder(myDraftOrder: draftOrder)
        return myDraftOrder
        
    }
    
}
