//
//  OrderViewController.swift
//  Shopify
//
//  Created by Mac on 19/06/2023.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel : OrderViewModelType?
    
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            }
        }
        viewModel?.fetchOrders(tag:"" , endPoint: .orders(tag: 7018538107189))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getOrdersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = viewModel?.getOrderAtIndexPath(row: indexPath.row)
        
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
     
        cell.orderDate.text = order?.processedAt
        cell.orderID.text = String(format: "%d", order?.orderNumber ?? 0)
        cell.orderPrice.text = order?.totalPrice
        
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
    

}