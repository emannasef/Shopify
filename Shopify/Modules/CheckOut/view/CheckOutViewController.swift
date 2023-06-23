
import UIKit
import PassKit
import Alamofire
import Lottie

class CheckOutViewController: UIViewController, RTCustomAlertDelegate {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var cashbtn: UIButton!
    @IBOutlet weak var applePayBtn: UIButton!
    
    var adressViewModel : AdressViewModel!
    var postOrderViewModel : PostOrderViewModelType!
    var draftorderVM: DraftOrderViewModel!
    var network : NetworkProtocol!
    var isapplyBtnappear : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        adressViewModel = AdressViewModel(network: network)
        postOrderViewModel = PostOrderViewModel(network: network)
        draftorderVM = DraftOrderViewModel(network: network)
        
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
        
        
        if (adressViewModel.adresses?.count ?? 0 > 0){
            let defaultAddress = adressViewModel.getDefaultAdress()
            userName.text = defaultAddress.name
            region.text = defaultAddress.province
            city.text = defaultAddress.city
        }
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
    
    
    @objc func tapForPay(){
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller?.delegate = self
            present(controller!,animated: true){
                
                print("process is completed")
            }
        }
    }
    
    
    @IBAction func supmitOrder(_ sender: Any) {
        
        if adressViewModel.adresses?.count ?? 0 > 0{
            
            // supmit your order here
            getOrderToSubmit()
            showSuccessAnimation()
        }
        else{
            let alert = UIAlertController(title: "Alert!", message: "Set a default address to supmit your order", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
                let addAddresScreen = self.storyboard?.instantiateViewController(identifier: "addAdressScreen")  as! AddAdressViewController
                self.navigationController?.pushViewController(addAddresScreen, animated: true)
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getOrderToSubmit() {
        let order = Order()
        var customer = OrderCustomer()
            customer.id = postOrderViewModel.getUserId()
            order.line_items = postOrderViewModel.getLineItems()
            order.customer = customer
            order.shipping_address = getAdress()
            order.discount_codes = []
            let params : Parameters = encodeToJson(objectClass: PostOrder(order: order)) ?? [:]
            postOrderViewModel.postOrder(endpoint: .postOrder, params:params )
            
    }
    
    func getAdress() -> PostedAdress{
        let address = adressViewModel.adresses?.last ?? adressViewModel.getDefaultAdress()
        return address
    }
    
    func showSuccessAnimation(){
        let customAlert = RTCustomAlert()
               customAlert.alertTitle = "Thank you"
               customAlert.alertMessage = "Your order successfully done."
               customAlert.alertTag = 1
               customAlert.isCancelButtonHidden = true
               customAlert.delegate = self
               customAlert.show()
    }
    
    func releaseCart(){
        MyCartItems.cartItemsCodableObject = []
       // draftorderVM.deleteItem(index: <#T##Int#>, draftOrderId: <#T##Int#>, customer: <#T##Customer#>)
    }
}



extension CheckOutViewController : PKPaymentAuthorizationViewControllerDelegate{
    
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true,completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func okButtonPressed(_ alert: RTCustomAlert, alertTag: Int) {
        
        if alertTag == 1 {
            print("Single button alert: Ok button pressed")
        } else {
            print("Two button alert: Ok button pressed")
        }
        print(alert.alertTitle)
    }
    
    func cancelButtonPressed(_ alert: RTCustomAlert, alertTag: Int) {
        print("Cancel button pressed")
    }

}
