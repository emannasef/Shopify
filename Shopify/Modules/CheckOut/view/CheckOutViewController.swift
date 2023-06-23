

import UIKit
import PassKit
import Alamofire

class CheckOutViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var cashbtn: UIButton!
    @IBOutlet weak var applePayBtn: UIButton!
  
    var adressViewModel : AdressViewModel!
    var network : NetworkProtocol!
    var isapplyBtnappear : Bool = false
    var postOrderViewModel : PostOrderViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        adressViewModel = AdressViewModel(network: network)
        postOrderViewModel = PostOrderViewModel(network: network)
       
        self.applePayBtn.addTarget(self, action: #selector(tapForPay), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        adressViewModel.bindAdressesToViewController = { [weak self] in
            DispatchQueue.main.async{
                self?.setUserAddress()
            
            }
            
        }
        adressViewModel.getCustomerAdresses(customerId:Int(UserDefaults.standard.string(forKey: "customerId") ?? "") ?? 0 )
    }
    
    func setUserAddress(){
        
        var defaultAddress = adressViewModel.getDefaultAdress()
        userName.text = defaultAddress.name
        region.text = defaultAddress.address1
        city.text = defaultAddress.city
    }
    
    @IBAction func payByApplePay(_ sender: Any) {
        self.applePayBtn.addTarget(self, action: #selector(tapForPay), for: .touchUpOutside)
        self.applePayBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        self.cashbtn.setImage(UIImage(systemName: ""), for: .normal)
        
    }
 
    
    @IBAction func paycash(_ sender: Any) {
        self.cashbtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        self.applePayBtn.setImage(UIImage(systemName: ""), for: .normal)
    }
  
  
      var paymentRequest : PKPaymentRequest = {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.mad43team2.com"
            request.supportedNetworks = [.idCredit,.visa]
            request.supportedCountries = ["EG"]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "EG"
            request.currencyCode = "EGP"
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Adidas shoes", amount: 2)]
            return request
        }()
    
   
    
    @IBAction func SubmitOrder(_ sender: UIButton) {
   
        let order = Order()
        let address = PostedAdress(firstName: "Haidy", lastName: "Yassin", city: "Cairo", region: "new Cairo", country: "Egypt", zip: "12345")
        var customer = OrderCustomer()
        customer.id = postOrderViewModel.getUserId()
        order.line_items = postOrderViewModel.getLineItems()
        order.customer = customer
        order.shipping_address = address
        order.discount_codes = []
        let params : Parameters = encodeToJson(objectClass: PostOrder(order: order)) ?? [:]
        postOrderViewModel.postOrder(endpoint: .postOrder, params:params )
        
    }
    
    
   @objc func tapForPay(){
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller?.delegate = self
            present(controller!,animated: true){
                
                print("process is completed")
            }
        }
    }
}

extension CheckOutViewController : PKPaymentAuthorizationViewControllerDelegate{
    
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true,completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

}
