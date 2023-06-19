import UIKit
import Alamofire
import Kingfisher

class ShoppingcartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTable:UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    var network : NetworkProtocol!
    var viewModel : DraftOrderViewModel!
    var settingViewModel :SettingsViewModel!
    var totalPrice:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        network = Network()
        viewModel = DraftOrderViewModel(network: network)
        settingViewModel = SettingsViewModel(network: network)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.bindDraftOrdersToViewControllers = { [weak self]   in
            
            DispatchQueue.main.async {
                print("Data saved")
                self?.myTable.reloadData()
            }
            
        }
        viewModel.getDraftOrders(draftOrderId:1117528654133)//getDraftOrdertId())
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.getDrftOrdersCount()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "itemCell") as! orderdItemTableCell
        self.setBtnShadow(btn: cell.decreaseBtn)
        self.setBtnShadow(btn: cell.increaseBtn)
        let item = viewModel.retriveAnOrder(index: indexPath.row)
        self.setCellData(cell: cell, item: item,index: indexPath.row)
        cell.layer.cornerRadius = 10.0
        cell.deleteitem = { [weak self] in
            guard let self = self else { return }
            self.deleteItem(cell: cell, index: indexPath.row)
        }
        
        return cell
    }
    
    func deleteItem(cell:orderdItemTableCell,index:Int){
        viewModel.deleteItem(index: index, draftOrderId: 1117528916277)//getDraftOrdertId())
        self.totalPrice -= Int(cell.itemPrice.text ?? "0") ?? 0
        cell.itemPrice.text = String(self.totalPrice)
       // self.myTable.deleteRows(at: [indexPath], with: .automatic)
       // viewModel.draftOrders?.remove(at: index)
        //myTable.reloadData()
        viewModel.getDraftOrders(draftOrderId: 1117528916277)
        
        createToastMessage(message: "item deleted from your card", view: self.view)
    }
    
    
    func setCellData(cell:orderdItemTableCell, item:LineItems, index:Int){
        
        cell.itemsNum.text = String(item.quantity ?? 0)
        setPrice(cell: cell, price: item.price ?? "",quantity: item.quantity ?? 0)
        cell.itemTitle.text = item.vendor
        cell.itemColor.text = item.variantTitle
        print("color is \(String(describing: item.vendor))")
        let imgUrl = URL(string: item.properties?[0].value ?? "")
        cell.itemImg.kf.setImage(with: imgUrl ,placeholder: "imagegirl" as? Placeholder)
        
    }
    
    func setPrice(cell:orderdItemTableCell,price:String,quantity:Int){
        
        settingViewModel.bindResultToviewController = { [weak self] in
            DispatchQueue.main.async{
                let price = self?.settingViewModel.result
                let convertedPrice = quantity * Int(price ??  0)
                self?.totalPrice += Int(convertedPrice)
                cell.itemPrice.text = String(convertedPrice)
                self?.totalAmount.text = String(self?.totalPrice ?? 0)
            }
        }
        settingViewModel.convertCurrency(to: getCurrency(), from: "USD", amount: price)
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
    
    
   /* @IBAction func checkOut(_ sender: Any) {
    }*/
}

