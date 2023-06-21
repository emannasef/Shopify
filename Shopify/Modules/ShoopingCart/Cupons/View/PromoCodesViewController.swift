
import UIKit

class PromoCodesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var PRICE_RULE_ID : Int?
    @IBOutlet weak var enterPromfield: UITextField!
    @IBOutlet weak var promoCodesTable: UITableView!
    @IBOutlet weak var cuponsTable: UITableView!
    var viewModel:CuponsViewModel!
    var network:NetworkProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        viewModel = CuponsViewModel(network: network)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return discountsArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = promoCodesTable.dequeueReusableCell(withIdentifier: "promocodecell") as! promocodeTableViewCell
        cell.offerLabel.text = discountsArr?[indexPath.section].discount?.code//viewModel.cupons?[indexPath.section].code
        cell.layer.cornerRadius = 10.0
        cell.offerBg.layer.cornerRadius = 10.0
        
        return cell
        
    }
    
    
    
}
