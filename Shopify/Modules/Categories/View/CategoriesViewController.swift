//
//  CategoriesViewController.swift
//  Shopify
//
//  Created by Mac on 18/06/2023.
//

import UIKit

class CategoriesViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var subCategoriesBtn: UIButton!
    
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    var viewModel = CategoriesViewModel.getInstatnce(network: NetworkManager())
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance)
    var productType = ""
    var subCategoriesList: [Product] = []
    var fromCategory:String!
    
    @IBOutlet weak var categoriesCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        let tapmeitems = UIMenu(title: "ProductsType", options: .displayInline, children: [
            UIAction(title: "All", image: UIImage(named: "all"), handler: { _ in self.getData()}),
        UIAction(title: "T-Shirts", image: UIImage(named: "tshirt"), handler:  { [unowned self] _ in
            productType = "T-Shirts"
            subCategoriesList = viewModel.getTShirts()
            categoriesCollection.reloadData()
            }),
        UIAction(title: "FootWear", image: UIImage(named: "shoes"), handler: { [unowned self] _ in
            productType = "FootWear"
            subCategoriesList = viewModel.getFootWear()
            categoriesCollection.reloadData()
            }),
        UIAction(title: "Accessories", image: UIImage(named: "sunglasses"), handler: { [unowned self] _ in
            productType = "Accessories"
            subCategoriesList = viewModel.getAccessories()
            categoriesCollection.reloadData()
        }),
        ])
        let menu = UIMenu(title: "", children: [tapmeitems])
        
        subCategoriesBtn.menu = menu
        
        let searchBtn = UIBarButtonItem(title: "", image: UIImage(named: "baseline-search-24px"), target: self, action: #selector(addTapped))
        self.tabBarController?.navigationItem.leftBarButtonItem = searchBtn

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        subCategoriesList = []
    }
    
    func getData(){
        productType = ""
        self.viewModel.bindCategoryToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.categoriesCollection.reloadData()
                
            }
        }
        if(getSelectedCategory() == 0){
            viewModel.fetchProducts(tag: "", endPoint: .allProducts)
        }else{
            viewModel.fetchProducts(tag:"" , endPoint: .products(tag: getSelectedCategory()))
        }
        
    }
    @IBAction func selectCategory(_ sender: Any) {
        productType = ""
        getData()
    }
    
    func getSelectedCategory()-> Int {
        switch(categoriesSegmentedControl.selectedSegmentIndex){
        case 0:
            return 0
        case 1:
            fromCategory = "men"
            return CategoryType.men.rawValue
        case 2:
            fromCategory = "women"
            return CategoryType.women.rawValue
        case 3:
            fromCategory = "kids"
            return CategoryType.kids.rawValue
        default:
            fromCategory = "sale"
            return CategoryType.sale.rawValue
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(productType == ""){
            return viewModel.getProductsCount()
        }
            else{
                return subCategoriesList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = viewModel.getProductAtIndexPath(row: indexPath.row)
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCell
        
        if(productType == "")
        {
            cell.ProductName.text = product.title
            cell.productImg.kf.setImage(
                with: URL(string: product.image?.src ?? ""),
                placeholder: UIImage(named: "brandplaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            cell.productPrice.text = product.variants?[0].price
        }else{
            cell.ProductName.text = subCategoriesList[indexPath.row].title
            cell.productImg.kf.setImage(
                with: URL(string: subCategoriesList[indexPath.row].image?.src ?? ""),
                placeholder: UIImage(named: "brandplaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            cell.productPrice.text = subCategoriesList[indexPath.row].variants?[0].price
        }
      
        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 3
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        cell.cellIndex = indexPath
        cell.delegate = self
        
        let favPro = FavProduct(id: product.id,title: product.title,rate: 3.5, price: "500", image: product.image?.src)

       if wishListViewModel.isProductExist(product: favPro) == true{
           cell.isFav.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
           
       }
        else{
            cell.isFav.setImage(UIImage(systemName: "heart" ), for: .normal)
           }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfo = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoVC") as! ProductInfoVC
            
            
            if(productType == "")
            {
                productInfo.productId = viewModel.getProductAtIndexPath(row: indexPath.row).id ?? 8360376402229
                
            }else{
                productInfo.productId  = subCategoriesList[indexPath.row].id ?? 8360376402229
            }
            self.navigationController?.pushViewController(productInfo, animated: true)
    }
    
    @objc func addTapped(){
        let productsScreen = storyboard?.instantiateViewController(withIdentifier: "collectionproducts") as! ProductsViewController
        productsScreen.fromScreen = fromCategory
        UserDefaults.standard.set(productsScreen.fromScreen, forKey: "Screen")
        navigationController?.pushViewController(productsScreen, animated: true)
    }
  
}

extension CategoriesViewController : ClickDelegate {
    func clicked(_ row: Int) {
        let pro:Product!
        if(productType == "")
        {
             pro = viewModel.getProductAtIndexPath(row: row)
            
        }else{
             pro  = subCategoriesList[row]
        }
        
        let favPro = FavProduct(id: pro.id,title: pro.title,rate: 3.5, price: pro.variants?[0].price, image: pro.image?.src)
        
        if  wishListViewModel.isProductExist(product: favPro) == false {
            wishListViewModel.insertFavProduct(product: favPro)
            categoriesCollection.reloadData()
            
        }else{
            let alert = UIAlertController(title: "Delete", message: "Do You want to remove this from your Wishlist?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] (action) in
                
                self?.wishListViewModel.deleteFavProduct(product: favPro)
                self?.categoriesCollection.reloadData()
            }))
            self.present(alert, animated: true)
        }
  
    }
    


}



