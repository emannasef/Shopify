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
    }
    
    func getData(){
        self.viewModel?.bindOrdersToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.ordersTable.reloadData()
            }
        }
        viewModel.fetchProducts(tag:"" , endPoint: .allProducts)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getOrdersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = viewModel?.getOrderAtIndexPath(row: indexPath.row)
        
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        cell.textLabel?.text = String(format:"%d", order?.orderNumber ?? 0)
        
        return cell
    }
    

}
