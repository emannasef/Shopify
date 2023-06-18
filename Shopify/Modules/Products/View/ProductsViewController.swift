//
//  ProductsViewController.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import UIKit


class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsCollection: UICollectionView!
    var collectionId:Int!
    var collectionName:String!
    var viewModel = ProductsViewModel.getInstatnce(network: NetworkManager())
    var allProductsViewModel = AllProducts(network: NetworkManager())
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance)
    
    var searchedArr:[Product] = []
    var productsArr:[Product] = []
    var fromScreen:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollection.delegate = self
        productsCollection.dataSource = self
        
       // print("from products \(collectionId)")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       // getData()
        if fromScreen == "Brand" {
            getData()
        }else {
            getAllProducts()
        }
    }
   
    func getData(){
        self.viewModel.bindProductsToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.productsArr = self?.viewModel.result ?? []
                self?.searchedArr = self?.productsArr ?? []
                self?.productsCollection.reloadData()

            }
        }
        viewModel.fetchProducts(tag:"" , endPoint: .brandsProducts(tag: collectionName))
     
    }
    
    func  getAllProducts() {
        allProductsViewModel.bindAllProductsToView = {[weak self] in
            self?.productsArr = self?.allProductsViewModel.res ?? []
            self?.searchedArr = self?.productsArr ?? []
            DispatchQueue.main.async {
                self?.productsCollection.reloadData()
            }
        }
        allProductsViewModel.getAllProducts()
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedArr.count
    // return  viewModel.getProductsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = searchedArr[indexPath.row]
       // let product = viewModel.getProductAtIndexPath(row: indexPath.row)
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
        
        cell.productPrice.text = product.variants?[0].price
        cell.cellIndex = indexPath
        cell.delegate = self

        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 3
        cell.layer.borderColor =  UIColor.systemGray6.cgColor

        let favPro = FavProduct(id: product.id,title: product.title,rate: 3.5, price: "500", image: product.image?.src)

       if wishListViewModel.isProductExist(product: favPro) == true{
           cell.isFavBtn.setImage(UIImage(named: "filled.png" ), for: .normal) }
        else{
            cell.isFavBtn.setImage(UIImage(named: "outlined.png" ), for: .normal)
           }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 277)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfo = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoVC") as! ProductInfoVC
        productInfo.productId = searchedArr[indexPath.row].id ?? 8360376402229
        self.navigationController?.pushViewController(productInfo, animated: true)
    }
    
}


extension ProductsViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedArr = []
        
        if searchText == "" {
            searchedArr = productsArr
        }

        for product in productsArr {
           // print (searchText)
            if product.title!.uppercased().contains(searchText.uppercased()){
             //   print("MyProduct",product.title)
                searchedArr.append(product)
            }

        }

        productsCollection.reloadData()
    }
}

extension ProductsViewController : ClickDelegate{
    
    func clicked(_ row: Int) {
        let pro = searchedArr[row]
        let favPro = FavProduct(id: pro.id,title: pro.title,rate: 3.5, price: "500", image: pro.image?.src)
  
        if  wishListViewModel.isProductExist(product: favPro) == false {
            let alert = UIAlertController(title: "\(String(describing: pro.title))", message: "Do You want to add this in your Wishlist?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] (action) in
                self?.wishListViewModel.insertFavProduct(product: favPro)
                print("Eman",self?.wishListViewModel.isProductExist(product: favPro))
                self?.productsCollection.reloadData()

            }))
            alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
            self.present(alert, animated: true)
            
        }else{
            let alert = UIAlertController(title: "\(String(describing: pro.title))", message: "Do You want to remove this from your Wishlist?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] (action) in
                
                self?.wishListViewModel.deleteFavProduct(product: favPro)
                self?.productsCollection.reloadData()
            }))
            self.present(alert, animated: true)
        }
    }
    
//    func addToFav(index: Int){
//       var pro = searchedArr[index]
//        var favPro = FavProduct(id: pro.id,title: pro.title,rate: 3.5, price: "500", image: pro.image?.src)
//
//
//        if  wishListViewModel.isProductExist(product: favPro) == false {
//
//            wishListViewModel.insertFavProduct(product: favPro)
//          //  addToFavImg.image = UIImage(named: "filled.png")
//
//            print("inserted")
//
//        }else{
//            wishListViewModel.deleteFavProduct(product: favPro)
//           // addToFavImg.image = UIImage(named: "outlined.png")
//            print("Nottttt")
//        }
//
//    }
    
    
}
