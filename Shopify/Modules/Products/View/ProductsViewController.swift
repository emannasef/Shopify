//
//  ProductsViewController.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var productsCollection: UICollectionView!
    var collectionId:Int!
    var viewModel = ProductsViewModel.getInstatnce(network: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollection.delegate = self
        productsCollection.dataSource = self
        
        print("from products \(collectionId)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        self.viewModel.bindProductsToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.productsCollection.reloadData()
               
            }
        }
        viewModel.fetchProducts(tag:"" , endPoint: .products(tag: collectionId))
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProductsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = viewModel.getProductAtIndexPath(row: indexPath.row)
        
        let cell = productsCollection.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        
        cell.productName.text = product.title
        cell.produtImg.kf.setImage(
            with: URL(string: product.image?.src ?? ""),
             placeholder: UIImage(named: "dress"),
             options: [
                 .scaleFactor(UIScreen.main.scale),
                 .transition(.fade(1)),
                 .cacheOriginalImage
             ])
        
        //cell.productPrice.text = product
        
        
        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 3
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 277)
    }

}
