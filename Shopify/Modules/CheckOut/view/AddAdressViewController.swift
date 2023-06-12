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
    func setAdressObj() -> Adress{
        
        let customerName = customerName.text
        let phoneNum = phoneNum.text
        let city = city.text
        let region = region.text
        let postalCode = zipCode.text
        let country = country.text
        
        return Adress(address1: region ?? "Not found", city: city ?? "Not found", name: customerName ?? "Not found", country: country ?? "Not found", zip: postalCode ?? "Not found", phone: phoneNum ?? "Not found")
    }

    @IBAction func chooseCountryBtn(_ sender: Any) {
        
        
    }
    

    @IBAction func saveAdress(_ sender: Any) {
        viewModel .addAdress(adress: setAdressObj())
        print("savedddd............")
    }
}
