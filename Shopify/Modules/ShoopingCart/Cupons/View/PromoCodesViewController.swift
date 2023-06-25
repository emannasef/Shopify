
import UIKit

class PromoCodesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var PRICE_RULE_ID : Int?
    @IBOutlet weak var enterPromfield: UITextField!
    @IBOutlet weak var promoCodesTable: UITableView!
    @IBOutlet weak var cuponsTable: UITableView!
    var viewModel:CuponsViewModel!
    var draftOrderViewModel : DraftOrderViewModel!
    var network:NetworkProtocol!
    var bindDiscountToViewController:() ->() = {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cuponsTable.backgroundColor = UIColor(named: "screenBg")
        network = Network()
        viewModel = CuponsViewModel(network: network)
        draftOrderViewModel = DraftOrderViewModel(network: network)
        viewModel.bindPricerulesToViewControllers = { [weak self] in
            DispatchQueue.main.async {
                let i = 0
                print("IDES COUNT \(String(describing: self?.viewModel.priceRuleIdes?.count))")
                    let id = self?.viewModel.priceRuleIdes?[i]
                    self?.viewModel.getCupons(priceruleId:id ?? 0)
              
                    
            }
        }
        viewModel.bindToViewController = {  [weak self] in
            DispatchQueue.main.async {
                //self?.setCuponsArr(totalCupons: self?.viewModel.totalCupons ?? [])
                print("your cupons...\(String(describing: self?.viewModel.cupons?.count))")
                self?.cuponsTable.reloadData()
            }
        }
        viewModel.getPriceRules()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cuponsTable.backgroundColor = UIColor(named: "screenBg")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.viewModel.cupons?.count ?? 0 //discountsArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cuponsTable.dequeueReusableCell(withIdentifier: "promocodecell") as! promocodeTableViewCell
        let discount = viewModel.cupons?[indexPath.section]
        cell.offerLabel.text = viewModel.cupons?[indexPath.section].code//discountsArr?[indexPath.section].discount?.code//viewModel.cupons?[indexPath.section].code
        
        cell.layer.cornerRadius = 10.0
        cell.offerBg.layer.cornerRadius = 10.0
        cell.bindApplyActionToViewController = { [weak self] in
            self?.viewModel.setSelectedDiscount(discount: discount! )
            ShoppingcartViewController.cuponsViewModel.setSelectedDiscount(discount: discount!)
          //  self?.applyDiscountCode()
           // let customer = Customer(id:Int(UserDefaults.standard.integer(forKey: "customerId")))
            //self?.draftOrderViewModel.applyDiscountToDraftOrder(discount:discount!, draftOrderId: getDraftOrdertId(), customer:customer)
           
          
        }
        
        return cell
        
    }
    
    @objc func applyDiscountCode(){
        bindDiscountToViewController()
    }
    
  /*  func applyDiscount(draftOrderId:Int,price:String,discount:Discount){
        draftOrderViewModel.applyDiscount(draftOrderId: draftOrderId, discount: discount, price: price, lineItems: MyCartItems.cartItemsCodableObject!)
    }*/
    
}
