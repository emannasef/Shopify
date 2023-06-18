//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mac on 12/06/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var homeCollection: UICollectionView!
    var viewmodel = HomeViewModel.getInstatnce(network: NetworkManager())
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollection.dataSource = self
        homeCollection.delegate = self
        self.navigationController?.navigationItem.title  = "Home"
        
        let searchBtn = UIBarButtonItem(title: "", image: UIImage(named: "baseline-search-24px"), target: self, action: #selector(addTapped))
        
        self.tabBarController?.navigationItem.leftBarButtonItem = searchBtn
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "outlined"), target: self, action: #selector(favScreen))
    
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
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
            return 10
        default:
            return viewmodel.getBrandsCount()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch(indexPath.section){
        case 0:
            let cell = homeCollection.dequeueReusableCell(withReuseIdentifier: "adCell", for: indexPath) as! AdsCell
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
            break
        default:
            let brand = viewmodel.getBrandAtIndexPath(row: indexPath.row)
            let productsScreen = storyboard?.instantiateViewController(withIdentifier: "collectionproducts") as! ProductsViewController
            productsScreen.collectionId = brand.id
            productsScreen.fromScreen = "Brand"
            print(String(brand.id))
            navigationController?.pushViewController(productsScreen, animated: true)
        }
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
    
    @objc func addTapped(){
        let productsScreen = storyboard?.instantiateViewController(withIdentifier: "collectionproducts") as! ProductsViewController
        navigationController?.pushViewController(productsScreen, animated: true)
    }
    
    @objc func favScreen(){

        let wishList = UIStoryboard(name: "WishList", bundle: nil).instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
        self.navigationController?.pushViewController(wishList, animated: true)
    }

}
