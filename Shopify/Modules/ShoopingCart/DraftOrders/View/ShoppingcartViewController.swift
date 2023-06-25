import UIKit
import SwiftUI
import Alamofire
import Kingfisher
import Reachability
import Lottie

class ShoppingcartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTable:UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var applyChangesBtn: UIButton!
    @IBOutlet weak var applyChangeBtn: UIButton!
    @IBOutlet weak var loading: LottieAnimationView!
    @IBOutlet weak var emptyImg: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceAfterDiscount: UILabel!
    @IBOutlet weak var curencyLabel2: UILabel!
    @IBOutlet weak var discountAmount: UILabel!
    var network : NetworkProtocol!
    var viewModel : DraftOrderViewModel!
    var settingViewModel :SettingsViewModel!
    var totalPrice:Double = 0.0
    var cell : orderdItemTableCell!
    var bacupItemsList : [LineItems]!
    var isApplyChangeBtn : Bool = false
      
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        viewModel = DraftOrderViewModel(network: network)
        settingViewModel = SettingsViewModel(network: network)
        setPrice()
       
        bacupItemsList = MyCartItems.cartItemsCodableObject
        print("\n  cart count \(String(describing: MyCartItems.cartItemsCodableObject?.count))")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if getDraftOrdertId() == 0{
            emptyImg.isHidden = false
           
        }
        else {
            emptyImg.isHidden = true
           
        }
        myTable.backgroundColor = UIColor(named: "screenbg")
        loading.layer.cornerRadius = 10.0
        playLottie()
        viewModel.bindDraftOrdersToViewControllers = { [weak self]   in
            DispatchQueue.main.async {
                self?.myTable.reloadData()
                self?.myTable.isHidden = false
                self?.loading.stop()
                self?.loading.isHidden = true
                print("draft order idddddd  \(getDraftOrdertId())")
                print("items count\(self?.viewModel.lineItems?.count ?? 0)")
                
            }
            
        }
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            viewModel.getDraftOrders(draftOrderId:getDraftOrdertId())
        }
        else{
            self.myTable.reloadData()
            self.myTable.isHidden = false
            self.loading.stop()
            self.loading.isHidden = true
            
        }
        
    }
    
    
    func playLottie(){
        myTable.isHidden = true
        self.loading.isHidden = false
        self.loading.contentMode = .scaleAspectFit
        self.loading.loopMode = .loop
        self.loading.animationSpeed = 0.5
        self.loading.play()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  MyCartItems.cartItemsCodableObject?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //MyCartItems.cartItemsCodableObject?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = myTable.dequeueReusableCell(withIdentifier: "itemCell") as? orderdItemTableCell
        self.setBtnShadow(btn: cell.decreaseBtn)
        self.setBtnShadow(btn: cell.increaseBtn)
        var item = viewModel.retriveAnOrder(index: indexPath.section)
        self.setCellData(cell: cell, item: item,index: indexPath.row)
        cell.layer.cornerRadius = 10.0
        cell.deleteitem = { [weak self] in
            guard let self = self else { return }
            self.deleteItem(cell: self.cell, index: indexPath.row,indexPath: indexPath)
        }
        
        cell.itemsNum.text = String(item.quantity ?? 0)
        
        cell.decreaseQuantity = {[weak self] in
            guard let self = self else { return }
            totalPrice = 0.0
            if item.quantity! > 1{
                item.quantity = (item.quantity ?? 0) - 1
                self.cell.itemsNum.text = String(item.quantity ?? 0)
                self.myTable.reloadData()
 
            }
            self.changePrice(cell: self.cell,  index:indexPath.section,item: item)
            MyCartItems.cartItemsCodableObject![indexPath.section] = item
            
        }
        
       cell.increaseQuantity = {[weak self] in
            guard let self = self else { return }
            totalPrice = 0.0
            item.quantity = (item.quantity ?? 0) + 1
            self.cell.itemsNum.text = String(item.quantity ?? 0)
            self.myTable.reloadData()
            self.changePrice(cell: self.cell,index:indexPath.section,item: item)
            MyCartItems.cartItemsCodableObject![indexPath.section] = item
        }
        return cell
    }
    
    func deleteItem(cell:orderdItemTableCell,index:Int,indexPath:IndexPath){
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            setDeletealert(cell: cell, index: indexPath.section, indexPath: indexPath)
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection \n set connection to apply your changes", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setDeletealert(cell:orderdItemTableCell,index:Int,indexPath:IndexPath){
        let alert = UIAlertController(title: "Confirmation!", message: "Remove item..?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
            self.viewModel.deleteItem(index: index, draftOrderId:getDraftOrdertId(),customer: Customer(id: UserDefaults.standard.integer(forKey: "customerId")))
            MyCartItems.cartItemsCodableObject?.remove(at: index)
            myTable.reloadData()
            self.totalPrice -= Double(cell.itemPrice.text ?? "0") ?? 0
            self.totalAmount.text = String(self.totalPrice)
            createToastMessage(message: "item deleted from your card", view: self.view)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{_ in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setCellData(cell:orderdItemTableCell, item:LineItems, index:Int){
        cell.itemsNum.text = String(item.quantity ?? 0)
        let itemPrice = Double(item.quantity ?? 0) * ( getCurrencyEquvelant() * (Double(item.price ?? "") ?? 0.0))
        cell.itemPrice.text = String(format: "%.2f",itemPrice)
        self.totalPrice = Double(self.totalPrice + itemPrice)
        self.totalAmount.text = String(format: "%.2f",totalPrice)
        cell.currencyLabel.text = getCurrency()
        cell.itemTitle.text = splitProductName(name:item.name ?? "").1
        cell.brand.text = splitProductName(name:item.name ?? "").0
        print("color is \(String(describing: item.vendor))")
        let imgUrl = URL(string: item.properties?[0].value ?? "")
        cell.itemImg.kf.setImage(with: imgUrl ,placeholder: "imagegirl" as? Placeholder)
        cell.itemImg.layer.borderWidth = 0.2
        cell.itemImg.layer.borderColor = UIColor(named: "screenbg")?.cgColor
        cell.itemImg.layer.cornerRadius = 10.0
        
    }
    
    func setPrice(){
        
        settingViewModel.bindResultToviewController = { [weak self] in
            DispatchQueue.main.async{
                self?.totalAmount.text = String(format: "%.2f", 0.0)
                self?.totalPrice = 0.0
                self?.currencyLabel.text = getCurrency()
                setCurrencyEquvelant(quote:  self?.settingViewModel.quote ?? 0.0)
                self?.myTable.reloadData()
                self?.myTable.isHidden = false
                self?.loading.stop()
                self?.loading.isHidden = true
            }
        }
        settingViewModel.convertCurrency(to: getCurrency(), from: "USD", amount: "5")
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

    @IBAction func applyChanges(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation!", message: "apply chnges..?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
             MyCartItems.cartItemsCodableObject = self.bacupItemsList
            self.viewModel.updateDraftOrder(draftOrderId: getDraftOrdertId(), customer: Customer(id:UserDefaults.standard.integer(forKey: "customerId")), listOfCartItems: MyCartItems.cartItemsCodableObject!)
            createToastMessage(message: "your cart updated succefully", view: self.view)
            self.applyChangesBtn.isHidden = true
            isApplyChangeBtn = false
        }))
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.cancel, handler:{_ in
            self.applyChangesBtn.isHidden = true
            self.isApplyChangeBtn = false
            alert.dismiss(animated: true)
            self.viewModel.getDraftOrders(draftOrderId: getDraftOrdertId())
            
         
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    func changePrice(cell:orderdItemTableCell,index:Int,item:LineItems){
        applyChangesBtn.isHidden = false
        isApplyChangeBtn = true
        bacupItemsList[index].quantity = item.quantity
    }
    
    @IBAction func checkOut(_ sender: Any) {
        if isApplyChangeBtn == true {
            let alert = UIAlertController(title: "Alert!", message: "apply your changes before check out", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            let paymentScreen = self.storyboard?.instantiateViewController(identifier: "CheckOutViewController") as! CheckOutViewController
            self.navigationController?.pushViewController(paymentScreen, animated: true)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isApplyChangeBtn == true {
            let alert = UIAlertController(title: "Alert!", message: "your changes discarded", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
        applyChangesBtn.isHidden = true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productInfo = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoVC") as! ProductInfoVC
        print("productId..\(String(describing: viewModel.lineItems?[indexPath.section].productId) )")
        productInfo.productId = viewModel.lineItems?[indexPath.section].productId ?? 8360376402229
        self.navigationController?.pushViewController(productInfo, animated: true)
    }
}


