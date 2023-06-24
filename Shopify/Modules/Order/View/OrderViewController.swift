//
//  OrderViewController.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import UIKit

class OrderViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var viewModel : OrderViewModelType?
    
    @IBOutlet weak var noItemsImg: UIImageView!
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = OrderViewModel.getInstatnce(network: NetworkManager())
        ordersTable.dataSource = self
        ordersTable.delegate = self
        
        let nib = UINib(nibName: "OrderCell", bundle: nil)
        ordersTable.register(nib, forCellReuseIdentifier: "orderCell")
        getData()
        
        
    }
    
    func getData(){
        self.viewModel?.bindOrdersToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.ordersTable.reloadData()
                if(self?.viewModel?.getOrdersCount() == 0){
                    self?.ordersTable.isHidden = true
                    self?.noItemsImg.isHidden = false
                }else{
                    self?.ordersTable.isHidden = false
                    self?.noItemsImg.isHidden = true
                }
            }
        }
        viewModel?.fetchOrders(tag:"" , endPoint: .orders(tag: viewModel?.getCustomerId() ?? 0))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getOrdersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = viewModel?.getOrderAtIndexPath(row: indexPath.row)
        
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
     
        cell.orderDate.text = DateFormate(orderDate: order?.processed_at ?? "3-11-2000") 
        cell.orderID.text = String(format: "%d", order?.order_number ?? 0)
        cell.orderPrice.text = order?.total_price
        
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
        details.order = viewModel?.getOrderAtIndexPath(row: indexPath.row)
        navigationController?.pushViewController(details, animated: true)
    }
}
