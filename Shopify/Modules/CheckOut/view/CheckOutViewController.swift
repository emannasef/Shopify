//
//  CheckOutViewController.swift
//  ShopifyCustomer
//
//  Created by Mac on 09/06/2023.
//

import UIKit
import PassKit
class CheckOutViewController: UIViewController {

    @IBOutlet weak var applePayBtn: UIButton!
    @IBOutlet weak var cashbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payByApplePay(_ sender: Any) {
    }
    
    @IBAction func paycash(_ sender: Any) {
    }
    
    
    func pay(){
        
        var paymentRequest : PKPaymentRequest = {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.mad43team2.com"
            return request
        }()
    }
}
