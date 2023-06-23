//
//  MeViewController.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishListCollection: UICollectionView!
    @IBOutlet weak var fullName: UILabel!
    
    var meViewModel : MeViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        meViewModel = MeViewModel.getInstatnce(network: NetworkManager())
        
        ordersTable.delegate = self
        ordersTable.dataSource = self
        wishListCollection.dataSource = self
        wishListCollection.delegate = self
        fullName.text = UserDefaults.standard.string( forKey: "customerName")
        let nib = UINib(nibName: "OrderCell", bundle: nil)
        ordersTable.register(nib, forCellReuseIdentifier: "orderCell")
        
        let nibb = UINib(nibName: "OrderProductsCell", bundle: nil)
        wishListCollection.register(nibb, forCellWithReuseIdentifier: "orderProductCell")
        
        getOrders()
    }
    
    
    func getOrders(){
        self.meViewModel?.bindOrdersToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.ordersTable.reloadData()
            }
        }
        meViewModel?.fetchOrders(tag:"" , endPoint: .orders(tag: meViewModel?.getCustomerId() ?? 0))
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
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(meViewModel.getOrdersCount() == 0){
              return 0
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = meViewModel.getOrderAtIndexPath(row: indexPath.row)
        
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as!  OrderCell
        cell.orderDate.text = order.processed_at
        cell.orderID.text = String(format: "%d", order.order_number ?? 0)
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
        details.order = meViewModel?.getOrderAtIndexPath(row: indexPath.row)
        navigationController?.pushViewController(details, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishListCollection.dequeueReusableCell(withReuseIdentifier: "orderProductCell", for: indexPath)
        
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
