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
    var productType = ""
    var subCategoriesList: [Product] = []
    
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
            return CategoryType.men.rawValue
        case 2:
            return CategoryType.women.rawValue
        case 3:
            return CategoryType.kids.rawValue
        default:
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
        return cell
    }
  
}


