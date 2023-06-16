
import UIKit

class PromoCodesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var enterPromfield: UITextField!
    
    @IBOutlet weak var promoCodesTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = promoCodesTable.dequeueReusableCell(withIdentifier: "promocodecell") as! promocodeTableViewCell
        
        cell.layer.cornerRadius = 10.0
        cell.offerBg.layer.cornerRadius = 10.0
        
        return cell
        
    }
    
 

}
