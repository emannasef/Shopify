//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var homeBar: UINavigationBar!
    @IBOutlet weak var homeCollection: UICollectionView!
    
   
    var settingViewModel: SettingsViewModel!
    var viewmodel = HomeViewModel.getInstatnce(network: NetworkManager())
    var cuponsVieModel :CuponsViewModel!
    var network : NetworkProtocol!
    var currentIndex = 0
    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        settingViewModel = SettingsViewModel(network: network)
        setPrice()
        cuponsVieModel = CuponsViewModel(network: network)
        homeCollection.dataSource = self
        homeCollection.delegate = self
        self.navigationController?.isToolbarHidden = true
        
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "baseline-search-24px"), target: self, action: #selector(searchScreen))
        
        self.tabBarController?.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "", image: UIImage(systemName: "heart.fill"), target: self, action: #selector(favScreen)),
            UIBarButtonItem(title: "", image: UIImage(systemName: "cart.fill"), target: self, action: #selector(cartScreen))
        ]
        
        setLayout()
        startTimer()
        cuponsVieModel.bindPricerulesToViewControllers = { [weak self] in
            DispatchQueue.main.async {
                let i = 0
                print("IDES COUNT \(String(describing: self?.cuponsVieModel.priceRuleIdes?.count))")
                    let id = self?.cuponsVieModel.priceRuleIdes?[i]
                    self?.cuponsVieModel.getCupons(priceruleId:id ?? 0)
              
                    
            }
        }
        cuponsVieModel.bindToViewController = {  [weak self] in
            DispatchQueue.main.async {
                self?.setCuponsArr(totalCupons: self?.cuponsVieModel.totalCupons ?? [])
                print("your cupons...\(String(describing: self?.cuponsVieModel.cupons?.count))")
            }
        }
        cuponsVieModel.getPriceRules()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()

    }
    
    func setPrice(){
        settingViewModel.bindResultToviewController = { [weak self] in
            DispatchQueue.main.async{
                setCurrencyEquvelant(quote:  self?.settingViewModel.quote ?? 0.0)
            }
        }
        settingViewModel.convertCurrency(to: getCurrency(), from: "USD", amount: "5")
    }
    
    func setCuponsArr (totalCupons:[Discount]){
        for e in totalCupons {
            let attachDiscount = AdsAttachedData (status: "unUsed", discount: e)
            MyDiscountArray.discountArrayCodableObject.append(attachDiscount)
        }
        
    }
    
    func getData(){
        self.viewmodel.bindBrandsToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.homeCollection.reloadData()
                
            }
        }
        viewmodel.fetchBrands(tag: "", endPoint: .brands)
    }
    
    func setLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return self.AdsSection()
            default:
                return self.BrandsSection()
            }
        }
        
        homeCollection.setCollectionViewLayout(layout, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return adsImageArray.count
        default:
            return viewmodel.getBrandsCount()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch(indexPath.section){
        case 0:
            let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "adCell", for: indexPath) as! AdsCell
            cell.adImage.image = UIImage(named: adsImageArray[indexPath.row])
            return cell
            
        default:
            let brand = viewmodel.getBrandAtIndexPath(row: indexPath.row)
            
            let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCell
            cell.brandName.text = brand.title
            
            cell.brandImage.kf.setImage(
                with: URL(string: brand.image.src ?? ""),
                placeholder: UIImage(named: "brandplaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        print("kind is \(kind)")
        let  sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeader", for: indexPath) as! HeaderReusableView
        print("from section header")
        if kind == UICollectionView.elementKindSectionHeader {
            
            switch(indexPath.section){
            case 0:
                break
            default:
                sectionHeader.titleLabel.text = "Brands"
                
            }
        }
        return sectionHeader
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.section){
        case 0:
            if MyDiscountArray.discountArrayCodableObject[indexPath.row].status == "unUsed"{
            MyDiscountArray.discountArrayCodableObject[indexPath.row].status = "used"
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "Cupon alreadt taken", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            break
        default:
            let brand = viewmodel.getBrandAtIndexPath(row: indexPath.row)
            let productsScreen = storyboard?.instantiateViewController(withIdentifier: "collectionproducts") as! ProductsViewController
            productsScreen.collectionId = brand.id
            productsScreen.collectionName = brand.rules[0].condition
            productsScreen.fromScreen = "Brand"
            UserDefaults.standard.set(productsScreen.fromScreen, forKey: "Screen")
            print(String(brand.id))
            navigationController?.pushViewController(productsScreen, animated: true)
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval:
                                        5, target: self, selector: #selector(moveToNextItem), userInfo: nil, repeats: true)
    }
    
    
    @objc func moveToNextItem(){
        
        if currentIndex < adsImageArray.count-1{
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        
        homeCollection.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    
    }
    
    func AdsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension:        .fractionalWidth(1), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    
    func BrandsSection()->NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    
    @objc func searchScreen(){
        let productsScreen = storyboard?.instantiateViewController(withIdentifier: "collectionproducts") as! ProductsViewController
        productsScreen.fromScreen = "Home"
        UserDefaults.standard.set(productsScreen.fromScreen, forKey: "Screen")
        navigationController?.pushViewController(productsScreen, animated: true)
    }
    
    @objc func favScreen(){
        
        let wishList = UIStoryboard(name: "WishList", bundle: nil).instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
        self.navigationController?.pushViewController(wishList, animated: true)
    }
    
    @objc func cartScreen(){

        let cart = UIStoryboard(name: "ShoppingCart", bundle: nil).instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingcartViewController
        self.navigationController?.pushViewController(cart, animated: true)
    }

}
