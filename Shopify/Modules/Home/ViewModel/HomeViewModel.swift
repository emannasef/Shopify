//
//  HomeViewModel.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import Foundation

protocol HomeViewModelType{
    
    var bindBrandsToViewController : (()->())? { get set }
    
    static func getInstatnce (network:NetworkServicing) -> HomeViewModel
    func fetchBrands(tag:String,endPoint:EndPoints)
    func getBrandsCount() -> Int
    func getBrandAtIndexPath(row:Int) -> SmartCollections
}


class HomeViewModel :HomeViewModelType{
   
    let network:NetworkServicing
    var bindBrandsToViewController: (() -> ())?
    var result: [SmartCollections] = []
    
    private init(network: NetworkServicing) {
        self.network = network
    }
    
    static func getInstatnce (network:NetworkServicing) -> HomeViewModel{
        return HomeViewModel(network: network)
    }
    
    func fetchBrands(tag:String,endPoint:EndPoints){
        network.getDataOverNetwork(tag: tag, endPoint: .brands) {[weak self] (result: BrandsResponse?) in
            print(result?.smartCollections?.count)
            self?.result = result?.smartCollections ?? []
            self?.bindBrandsToViewController?()
        }
    }
    
    func getBrandsCount() -> Int {
        return result.count
    }
    
    func getBrandAtIndexPath(row:Int) -> SmartCollections {
        result[row]
    }
    
}

