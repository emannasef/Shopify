
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
        self.setAdressField()
    }
  
    func setAdressField(){
        
        let id = Int(UserDefaults.standard.string(forKey: "customerId") ?? "") ?? 0
        addressViewModel.getCustomerAdresses(customerId: id )
        addressViewModel.bindAdressesToViewController = { [weak self] in
            DispatchQueue.main.async {
                let adress = self?.addressViewModel.getDefaultAdress()
                self?.city.text = adress?.city
                self?.region.text = adress?.address1
            }
        }
       
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
        
        if addressViewModel.adresses?.count == 0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "CheckOut", bundle:nil) /// <- Different storyboard
            let addAdressScreen = storyBoard.instantiateViewController(identifier: "addAdressScreen") as! AddAdressViewController
            addAdressScreen.staus = "add"
            self.navigationController?.pushViewController(addAdressScreen, animated: true)
        }
        else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "CheckOut", bundle:nil) /// <- Different storyboard
            let adressScreen = storyBoard.instantiateViewController(identifier: "adressScreen") as! AdressesViewController
            self.navigationController?.pushViewController(adressScreen, animated: true)
        }
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
        UserDefaults.standard.set("", forKey: "customerId")
        UserDefaults.standard.set("", forKey: "customerName")
        UserDefaults.standard.set("", forKey: "customerEmail")

      //  UserDefaults.standard.set("user", forKey: "UserType")
        let welcomeVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(welcomeVC , animated: true)
    }
    
}
