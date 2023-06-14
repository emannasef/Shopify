import UIKit

class AddAdressViewController: UIViewController {

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var zipCodeView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var country: UITextField!
    var choosedCountry : String!
    var viewModel : AdressViewModel!
    var network : Network!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        network = Network()
        viewModel = AdressViewModel(network: network)
        
    }
    func setAdressObj() -> PostedAdress{
        
        let customerName = customerName.text
        let city = city.text
        let region = region.text
        //let adress = Adress(name: customerName ?? "", city: city ?? "", region: region ?? "")
        let adress = PostedAdress(name: customerName ?? "", city: city ?? "", region: region ?? "")
        return adress
    }

    @IBAction func chooseCountryBtn(_ sender: Any) {
        
        
    }
    

    @IBAction func saveAdress(_ sender: Any) {
       viewModel .addAdress(adress: setAdressObj(),customerId: 7037983686965)
        print("savedddd............")
    }
}
