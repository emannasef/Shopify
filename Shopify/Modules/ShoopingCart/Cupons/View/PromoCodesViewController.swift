
import UIKit

class PromoCodesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private let PRICE_RULE_ID = 1380775067957
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
        viewModel.bindToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.cuponsTable.reloadData()
                print("Data Recived")
            }
        }
        viewModel.getCupons(priceruleId: PRICE_RULE_ID )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getCountOfCupons()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = promoCodesTable.dequeueReusableCell(withIdentifier: "promocodecell") as! promocodeTableViewCell
        cell.offerLabel.text = viewModel.cupons?[indexPath.section].code
        cell.layer.cornerRadius = 10.0
        cell.offerBg.layer.cornerRadius = 10.0
        
        return cell
        
    }
    
 

}
