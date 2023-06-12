//
//  ShoppingcartViewController.swift
//  ShopifyCustomer
//
//  Created by Mac on 07/06/2023.
//

import UIKit
import Alamofire

class ShoppingcartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
 
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    var items : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // var networkManger = Network()
        items = ["","",""]
        
        
    }
  

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "itemCell") as! orderdItemTableCell
        self.setBtnShadow(btn: cell.decreaseBtn)
        self.setBtnShadow(btn: cell.increaseBtn)
        cell.layer.cornerRadius = 10.0
        
        cell.deleteitem = { [weak self] in
            guard let self = self else { return }
            
            items.remove(at: indexPath.row)
            myTable.reloadData()
        }
        
        return cell
    }
    
    func setBtnShadow(btn:UIButton){
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 0.0
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 18
    }
    
   
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    @IBAction func promoCodeBtn(_ sender: Any) {
        lazy var promoCodesSection = self.storyboard?.instantiateViewController(withIdentifier: "promoCodesSheet")
        
        guard let sheet = promoCodesSection?.sheetPresentationController else {
            return
        }
      
        sheet.detents = [.medium(),.large()]
        sheet.prefersGrabberVisible = true
        sheet.preferredCornerRadius = 34
        self.present(promoCodesSection!, animated: true)
        
    }
    @IBAction func checkOutbtn(_ sender: Any) {
    }
  
    
    
}
