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
    let userType =  UserDefaults.standard.string(forKey: "UserType")
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance,network: Network())
    var wishArr:[FavProduct]!
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
            wishArr = wishListViewModel.getSoredFavs()
        }
        
        
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let loginVC =  UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC , animated: true, completion: nil)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        
        cell.layer.cornerRadius = 8
        cell.layer.shadowRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.30
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 1
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        
        return cell
    }
}
extension MeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if wishArr.isEmpty {
            return 1
        }else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishListCollection.dequeueReusableCell(withReuseIdentifier: "orderProductCell", for: indexPath)
     //   let wishPro1 = wishArr[0]
//        let wishPro2 = wishArr[1]
     //   print(wishPro1)
      //  print(wishPro2)
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
    
}

