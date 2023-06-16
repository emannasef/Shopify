//
//  MyCoreData.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import Foundation
import CoreData
import UIKit

class MyCoreData:MyCorDataProtocol {
    
    var manager : NSManagedObjectContext!
    var productArr : [NSManagedObject] = []
    var productToBeDeleted : NSManagedObject?
    
    static let sharedInstance = MyCoreData()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    
    func insertFavProduct(product: FavProduct) {
        let entity = NSEntityDescription.entity(forEntityName: "WishList", in: manager)
        let myProduct = NSManagedObject(entity: entity!, insertInto: manager)
        
        myProduct.setValue(product.id, forKey: "product_Id")
        myProduct.setValue(product.title, forKey: "product_title")
        myProduct.setValue(product.image, forKey: "product_Img")
        myProduct.setValue(product.price, forKey: "product_price")
        myProduct.setValue(product.rate, forKey: "product_rate")
        
        do{
            try manager.save()
            print("Product Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getStoredProducts() -> [FavProduct] {
        var products = [FavProduct]()
        let fetch = NSFetchRequest<NSManagedObject>(entityName:  "WishList")

        do{
            productArr = try manager.fetch(fetch)
            if(productArr.count > 0){
                productToBeDeleted = productArr.first
            }

            for i in productArr{
               var myProduct = FavProduct()
               
                myProduct.id = i.value(forKey: "product_Id") as? Int
                myProduct.rate = i.value(forKey: "product_rate") as? Double
                myProduct.price = i.value(forKey: "product_price") as? String
                myProduct.title = i.value(forKey: "product_title") as? String
                myProduct.image = i.value(forKey: "product_Img") as? String
                products.append(myProduct)
            }

        }catch let error{
            print(error.localizedDescription)
        }

        return products
    }
    
    func deleteFavProduct(product: FavProduct) {
        for i in productArr{
            if ((i.value(forKey: "product_title") as! String) == product.title){

               productToBeDeleted = i
            }
        }

        guard let product1 = productToBeDeleted else{
            print("cannot be deleted!")
            return
        }
        manager.delete(product1)
        do{
            try manager.save()
            print("FavProduct Deleted!")
        productToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
            print("FavProduct not deleted!!")
        }
    }
    
    func isProductExist(product: FavProduct) -> Bool {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "WishList")
        let predicate = NSPredicate(format: "product_Id == %i", product.id ?? 0)

        fetch.predicate = predicate
        
        do{
            productArr = try manager.fetch(fetch)
            if(productArr.count > 0){
                print("Fav is exist")
                return true
            }else{
                print("Fav is Not exist")
                return false
            }


        }catch let error{
            print(error.localizedDescription)
        }

        return false
    }
    
    
    
}
