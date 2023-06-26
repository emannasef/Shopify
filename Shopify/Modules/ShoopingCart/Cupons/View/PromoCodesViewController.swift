
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
               // self?.isCuponTaken(cupons: self?.viewModel.cupons ?? [])
                }
                self?.cuponsTable.reloadData()
            }
        
        viewModel.getPriceRules()
    }
    
    
    func unUsedArr(arr:[AdsAttachedData]) -> [AdsAttachedData]{
     
        let arr = discountsArr?.filter({ $0.status == "unUsed" }) ?? []
        return arr
    }
    
    func isCuponTaken(cupons:[Discount]){
        
        var i = 0
        while i < discountsArr?.count ?? 0 {
            var arr = discountsArr?.filter({ $0.discount == cupons[i] })
            if  arr?.count == 0 {
                discountsArr?.append(AdsAttachedData(status: "unUsed", discount: cupons[i]))
            }
        }
        //MyDraftOrder(myDraftOrder: getDraftOrdertId())
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cuponsTable.backgroundColor = UIColor(named: "screenBg")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.viewModel.cupons?.count ?? 0 //discountsArr?.count ?? 0 //unUsedArr(arr: discountsArr ?? []).count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cuponsTable.dequeueReusableCell(withIdentifier: "promocodecell") as! promocodeTableViewCell
        let discount =  viewModel.cupons?[indexPath.section] //unUsedArr(arr: discountsArr ?? [])[indexPath.section].discount
        cell.offerLabel.text = viewModel.cupons?[indexPath.section].code//discountsArr?[indexPath.section].discount?.code//viewModel.cupons?[indexPath.section].code
        cell.layer.cornerRadius = 10.0
        cell.offerBg.layer.cornerRadius = 10.0
        cell.bindApplyActionToViewController = { [weak self] in
            if discountsArr?[indexPath.section].status == "unUsed"{
                self?.viewModel.setSelectedDiscount(discount: discount ?? Discount() )
                ShoppingcartViewController.cuponsViewModel.setSelectedDiscount(discount: discount!)
                discountsArr?.remove(at: indexPath.section)
                discountsArr?[indexPath.section].status = "used"
                self?.cuponsTable.reloadData()
            }
            else {
                let alert = UIAlertController(title: "Alert!", message: "Discount Already Used", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self?.present(alert, animated: true, completion: nil)
            }
            
        }
        return cell
        
    }
    
    @objc func applyDiscountCode(){
        bindDiscountToViewController()
    }
    
    
}

