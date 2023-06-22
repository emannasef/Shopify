//
//  WishListVC.swift
//  Shopify
//
//  Created by Mac on 16/06/2023.
//

import UIKit
import Reachability
class WishListVC: UIViewController {
    
    @IBOutlet weak var noItemsImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance,network: Network())
    var wishListArr:[FavProduct] = []
    let draftyID = UserDefaults.standard.string(forKey: "UserWishListID")
    var wishListArrLines:[LineItems] = []
    var reachability:Reachability?
    var isConnected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        do{
            reachability = try Reachability()
            try reachability?.startNotifier()
        }
        catch{
            print("cant creat object of rechability")
            print("Unable to start notifier")
        }
        
        rech()
        
        wishListViewModel.getWishList(Draftid: draftyID!)
        
        wishListViewModel.bindingData = { [weak self] in
            self?.wishListArrLines = self?.wishListViewModel.allLineItemsArr ?? []
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            print("my Arrrray",self?.wishListArrLines)
        }
        
     
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if wishListViewModel.getSoredFavs().count != 0 {
            wishListArr = wishListViewModel.getSoredFavs()
            collectionView.reloadData()
            noItemsImg.isHidden = true
           
        }else{
            noItemsImg.isHidden = false
            noItemsImg.image = UIImage(named:"noitems")
        }
        
    }
    
    
    func rech (){
        reachability?.whenReachable = { reachability in
            self.isConnected = true
//            if reachability.connection == .wifi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//            }
        }
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.isConnected = false
            self.collectionView.reloadData()
          
        }
    }

}
extension WishListVC : UICollectionViewDelegate,UICollectionViewDataSource,ClickDelegate{
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCell
        print("Is Connected",isConnected)
        
//        let product : FavProduct!
//        if(isConnected)
//        {
//            let pro = wishListArrLines[indexPath.row]
//            product = FavProduct(id: pro.productId,title: pro.title,price: pro.price)
//
//        }else{
//             product  = wishListArr[indexPath.row]
//        }
        
        
        let product = wishListArr[indexPath.row]
        cell.wishListTitle.text = product.title
        
        let imgProductUrl = URL(string: product.image ?? "")
        
        cell.wishListImage.kf.setImage(
            with: imgProductUrl,
            placeholder: UIImage(named: "dress") , options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        cell.cellIndex = indexPath
        cell.delegate = self
        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 3
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfo = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoVC") as! ProductInfoVC
        productInfo.productId = wishListArr[indexPath.row].id ?? 8360376402229
        self.navigationController?.pushViewController(productInfo, animated: true)
    }
    
    func clicked(_ row: Int) {
        let pro = wishListArr[row]
        let favPro = FavProduct(id: pro.id,title: pro.title,rate: 3.5, price: "500", image: pro.image)
        
        let alert = UIAlertController(title: "\(String(describing: pro.title))", message: "Do You want to remove this from your Wishlist?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            
            self.wishListViewModel.deleteFavProduct(product: favPro)
            self.wishListViewModel.getSoredFavs()
            self.wishListArr.remove(at: row)
            self.collectionView.reloadData()
            
            if self.wishListArr.count == 0{
                self.noItemsImg.isHidden = false
                self.noItemsImg.image = UIImage(named:"noitems")
            }else{
                self.noItemsImg.isHidden = true
            }
            
        }))
        self.present(alert, animated: true)
    }
}
