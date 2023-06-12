import UIKit

class ShoppingAdressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var checkAsDefaultBtn: UIButton!    
    var viewModel : AdressViewModel!
    var network : Network!
    override func awakeFromNib() {
        super.awakeFromNib()
        network = Network()
        viewModel = AdressViewModel(network: network)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func setAsDefaultBtn(_ sender: Any) {
       
    
    
    }
}
