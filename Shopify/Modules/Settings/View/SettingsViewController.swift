
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var currencyMenu: UIButton!
    @IBOutlet weak var region: UITextField!
    var addressViewModel :AdressViewModel!
    var network :NetworkProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Network()
        addressViewModel = AdressViewModel(network: network)
        self.currency.text = getCurrency()
        self.fullName.text = UserDefaults.standard.string(forKey: "customerName")
        self.region.text = addressViewModel.getDefaultAdress().address1
        self.city.text = addressViewModel.getDefaultAdress().city
        
    }
    
    func setdressField(){
        
        let adress = addressViewModel.getDefaultAdress()
        city.text = adress.city
        region.text = adress.address1
    }
    
    func setCueencies() -> [UIAction]{
         
        var list : [UIAction]! = []
        for cur in currencies{
           
            let currency = UIAction(title: cur ) { (action) in
                setCurrency(currency: cur)
                self.currency.text = getCurrency()
              
             }
            list.append(currency)
        }
        return list
    }
    
    @IBAction func changeAdress(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "CheckOut", bundle:nil) /// <- Different storyboard!

        let adressScreen = storyBoard.instantiateViewController(identifier: "adressScreen") as! AdressesViewController
        
        self.navigationController?.pushViewController(adressScreen, animated: true)
    }
    
    @IBAction func chooseCurrency(_ sender: Any) {
    
        let menu = UIMenu(title: "", options: .displayInline, children: setCueencies())
        
       currencyMenu.menu = menu
        currencyMenu.showsMenuAsPrimaryAction = true
    }
    

    
    @IBAction func displayappInfo(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        let welcomeVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(welcomeVC , animated: true)
    }
    
}
