//
//  MeViewController.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet weak var notLoginView: UIView!
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishListCollection: UICollectionView!
    @IBOutlet weak var fullName: UILabel!
    
    
    @IBOutlet weak var meNavigationItem: UINavigationItem!
    
    let userType =  UserDefaults.standard.string(forKey: "UserType")
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance,network: Network())
    var wishArr:[FavProduct]!
    var meViewModel : MeViewModelType!
    override func viewDidLoad() {
        super.viewDidLoad()

        meViewModel = MeViewModel.getInstatnce(network: NetworkManager())
        
        if userType == "guest" {
            notLoginView.isHidden = false
        }else {
            ordersTable.delegate = self
            ordersTable.dataSource = self
            wishListCollection.dataSource = self
            wishListCollection.delegate = self
            fullName.text = UserDefaults.standard.string( forKey: "customerName")
            let nib = UINib(nibName: "OrderCell", bundle: nil)
            ordersTable.register(nib, forCellReuseIdentifier: "orderCell")
            
            let nibb = UINib(nibName: "OrderProductsCell", bundle: nil)
            wishListCollection.register(nibb, forCellWithReuseIdentifier: "orderProductCell")
            
            notLoginView.isHidden = true
            getOrders()
        }
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wishArr = wishListViewModel.getSoredFavs()
        wishListCollection.reloadData()
        
        if wishListViewModel.getSoredFavs().count > 2 {
            wishArr = [wishListViewModel.getSoredFavs()[0],wishListViewModel.getSoredFavs()[1]]
            wishListCollection.reloadData()
        }
        
    }
    
    func getOrders(){
        self.meViewModel.bindOrdersToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.ordersTable.reloadData()
            }
        }
        meViewModel.fetchOrders(tag:"" , endPoint: .orders(tag: meViewModel.getCustomerId() ))
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let loginVC =  UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        let registerVC =  UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func settingAction(_ sender: Any) {
        
        let setting = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(setting, animated: true)
      
    }
    
    @IBAction func showAllOrders(_ sender: UIButton) {
        let orders = storyboard?.instantiateViewController(withIdentifier: "allOrders") as! OrderViewController
        navigationController?.pushViewController(orders, animated: true)
        
    }

    @IBAction func showWishList(_ sender: UIButton) {
        let wishList = UIStoryboard(name: "WishList", bundle: nil).instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
        self.navigationController?.pushViewController(wishList, animated: true)
        
    }
  
}
extension MeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(meViewModel.getOrdersCount() == 0){
            return 0}
        else if(meViewModel.getOrdersCount() == 1){
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = meViewModel.getOrderAtIndexPath(row: indexPath.row)
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        
        cell.orderID.text = String(format: "%d", order.order_number ?? 0)
        cell.orderDate.text = DateFormate(orderDate: order.processed_at ?? "3-11-2000") 
        cell.orderPrice.text = order.total_price
        
        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 1
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = storyboard?.instantiateViewController(withIdentifier: "orderDetails") as! OrderDetailsViewController
        details.order = meViewModel.getOrderAtIndexPath(row: indexPath.row)
        navigationController?.pushViewController(details, animated: true)
    }
}
extension MeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishListCollection.dequeueReusableCell(withReuseIdentifier: "orderProductCell", for: indexPath) as! OrderProductsCell
        let wishPro = wishArr[indexPath.row]
        cell.productImage.kf.setImage(
            with: URL(string: wishPro.image ?? ""),
            placeholder: UIImage(named: "brandplaceholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        cell.productName.text = wishPro.title
        cell.isFav.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
        
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
        return CGSize(width: 167, height: 232)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfo = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoVC") as! ProductInfoVC
        productInfo.productId = wishArr[indexPath.row].id ?? 8360376402229
        self.navigationController?.pushViewController(productInfo, animated: true)
    }
    
}

