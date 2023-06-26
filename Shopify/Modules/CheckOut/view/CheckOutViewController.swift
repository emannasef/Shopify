
import UIKit
import PassKit
import Alamofire
import Lottie

class CheckOutViewController: UIViewController, RTCustomAlertDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var cashbtn: UIButton!
    @IBOutlet weak var applePayBtn: UIButton!
    @IBOutlet weak var itemsCollection: UICollectionView!
    @IBOutlet weak var totalPriceText: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var adressViewModel : AdressViewModel!
    var postOrderViewModel : PostOrderViewModelType!
    var draftorderVM: DraftOrderViewModel!
    var network : NetworkProtocol!
    var isapplyBtnappear : Bool = false
    var lineItems : [LineItems]!
    var totalPrice:Double = 0.0 
    var isPayed:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        adressViewModel = AdressViewModel(network: network)
        postOrderViewModel = PostOrderViewModel(network: network)
        draftorderVM = DraftOrderViewModel(network: network)
        isPayed = false
        
        self.applePayBtn.addTarget(self, action: #selector(tapForPay), for: .touchUpInside)
        
        let nib = UINib(nibName: "OrderProductsCell", bundle: nil)
        itemsCollection.register(nib, forCellWithReuseIdentifier: "orderProductCell")
        itemsCollection.dataSource = self
        itemsCollection.delegate = self
        lineItems = postOrderViewModel.getLineItems()
        totalPriceText.text = String(format: "%0.2f", totalPrice)
        currencyLabel.text = getCurrency()
        
        
        adressViewModel.bindAdressesToViewController = { [weak self] in
            DispatchQueue.main.async{
                self?.setUserAddress()
                
            }
            
        }
        
        adressViewModel.getCustomerAdresses(customerId:Int(UserDefaults.standard.string(forKey: "customerId") ?? "") ?? 0 )
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
        self.applePayBtn.tintColor = UIColor(named: "AccentColor")
        self.cashbtn.setImage(UIImage(systemName: ""), for: .normal)
        self.cashbtn.tintColor = UIColor.white
        isPayed = true
        
    }
    
    
    @IBAction func paycash(_ sender: Any) {
        
        if totalPrice > 1000.0{
            let alert = UIAlertController(title: "Alert!", message: "Huge amount pay by Apple pay", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            isPayed = true
            self.cashbtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.cashbtn.tintColor = UIColor(named: "AccentColor")
            self.applePayBtn.setImage(UIImage(systemName: ""), for: .normal)
            self.applePayBtn.tintColor = UIColor.white
        }
    }
    
    
    var paymentRequest : PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.mad43team2.com"
        request.supportedNetworks = [.idCredit,.visa]
        request.supportedCountries = ["EG"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "EG"
        request.currencyCode = getCurrency()
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Adidas shoes", amount: 2)]
        return request
    }()
    
    
    @objc func tapForPay(){
        var paymentRequest : PKPaymentRequest = {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.mad43team2.com"
            request.supportedNetworks = [.idCredit,.visa]
            request.supportedCountries = ["EG"]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "EG"
            request.currencyCode = getCurrency()
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Adidas shoes", amount:NSDecimalNumber(value: totalPrice))]
            return request
            
            
        }()
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
            if isPayed{
                getOrderToSubmit()
                postOrderViewModel.bindPostresponse = {[weak self] in
                    DispatchQueue.main.async {
                        if((self?.checkifOrderPosted()) != nil){
                            self?.releaseCart()
                            self?.showSuccessAnimation()
                        }else{
                            self?.showFailureAnimation()
                        }
                    }
                }
                
            }
            else {
                let alert = UIAlertController(title: "Alert!", message: "Choose payment method", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Alert!", message: "Set a default address to supmit your order", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
                let addAddresScreen = self.storyboard?.instantiateViewController(identifier: "addAdressScreen")  as! AddAdressViewController
                addAddresScreen.staus = "add"
                self.navigationController?.pushViewController(addAddresScreen, animated: true)
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getOrderToSubmit() {
        let order = Order()
        var customer = OrderCustomer()
            customer.id = postOrderViewModel.getUserId()
            order.line_items = lineItems
            order.customer = customer
            order.shipping_address = getAdress()
            order.discount_codes = []
            let params : Parameters = encodeToJson(objectClass: PostOrder(order: order)) ?? [:]
            postOrderViewModel.postOrder(endpoint: .postOrder, params:params )
            
    }
    
    func checkifOrderPosted() -> Bool{
        if(postOrderViewModel.myError == nil){
            return true
        }else{
            return false
        }
    }
    
    func getAdress() -> PostedAdress{
        let address = adressViewModel.adresses?.last ?? adressViewModel.getDefaultAdress()
        return address
    }
    
    func showSuccessAnimation(){
        let customAlert = RTCustomAlert()
               customAlert.alertTitle = "Thank you"
               customAlert.alertMessage = "Your order successfully done."
        customAlert.orderAnimation = .init( name: "postorerlottie")
               customAlert.alertTag = 1
               customAlert.isCancelButtonHidden = true
               customAlert.delegate = self
               customAlert.show()
    }
    
    func showFailureAnimation(){
        let customAlert = RTCustomAlert()
               customAlert.alertTitle = "Error"
               customAlert.alertMessage = "UnExpected Error happened, please Try Agin"
              customAlert.orderAnimation = .init( name: "postorerlottie")
               customAlert.alertTag = 1
               customAlert.isCancelButtonHidden = true
               customAlert.delegate = self
               customAlert.show()
    }
    
    func releaseCart(){
        let customer = Customer(id:Int(UserDefaults.standard.integer(forKey: "customerId")))
        let items = LineItems(title: "Dress" , varientTitle: "lll" , price: "99" , properties: [Properties(name: "img_url", value:"https://cdn.shopify.com/s/files/1/0767/9013/7124/products/8072c8b5718306d4be25aac21836ce16.jpg?v=1685539054")], quantity: 1)
        draftorderVM.clearDraftOrder(draftOrderId: getDraftOrdertId(), customer: customer, lineItems: [items])
        
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
        
        let homeScreen = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as! UITabBarController
        self.navigationController?.pushViewController(homeScreen, animated: true)
    }
    
    func cancelButtonPressed(_ alert: RTCustomAlert, alertTag: Int) {
        print("Cancel button pressed")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lineItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollection.dequeueReusableCell(withReuseIdentifier: "orderProductCell", for: indexPath) as! OrderProductsCell
        
        cell.productName.text = lineItems[indexPath.row].title
        cell.productImage.kf.setImage(
            with: URL(string: lineItems[indexPath.row].properties?[0].value ?? ""),
            placeholder: UIImage(named: "brandplaceholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        cell.productPrice.text = lineItems[indexPath.row].price
        cell.currencyLabel.text = getCurrency()
        
        cell.isFav.isHidden = true
        cell.layer.cornerRadius = 8
       // cell.layer.shadowRadius = 4
       // cell.layer.shadowColor = UIColor.black.cgColor
       // cell.layer.shadowOpacity = 0.30
       //cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.borderWidth = 3
        cell.layer.borderColor =  UIColor.systemGray6.cgColor
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 232)
    }
}
