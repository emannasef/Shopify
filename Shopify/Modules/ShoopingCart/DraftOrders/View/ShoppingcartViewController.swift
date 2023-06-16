import UIKit
import Alamofire
import Kingfisher

class ShoppingcartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTable:UITableView!
    @IBOutlet weak var totalAmount: UILabel!
    var items : [String]!
    var network : NetworkProtocol!
    var viewModel : DraftOrderViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        viewModel = DraftOrderViewModel(network: network)
        items = ["","",""]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.bindDraftOrdersToViewControllers = { [weak self]   in
            
            DispatchQueue.main.async {
                print("Data saved")
                self?.myTable.reloadData()
            }
            
        }
        viewModel.getDraftOrders(customerEmail:"emann@yahoo.com")
    }
    
    func filterDraftOrders(orders:[DraftOrders], customerEmail : String) -> DraftOrders{
        
        var result : DraftOrders?
        let i = 0
        while orders[i].note == "cart" && orders[i].customer?.email == customerEmail{
            result = orders[i]
        }
        return result ?? DraftOrders()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDrftOrdersCount()
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
            
           //items.remove(at: indexPath.row)
           // myTable.reloadData()
        }
        
        return cell
    }
    
    func setCellData(cell:orderdItemTableCell, item:LineItems, index:Int){
        
        cell.itemsNum.text = String(item.quantity ?? 0)
        cell.itemPrice.text = item.price
        cell.itemTitle.text = item.vendor
        // cell.itemsize = draftOrder.lineItems.
        cell.itemColor.text = item.variantTitle
        print("color is \(item.vendor)")
        var imgUrl = URL(string: item.properties?[0].value ?? "")
        cell.itemImg.kf.setImage(with: imgUrl ,placeholder: "imagegirl" as? Placeholder)
        
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

