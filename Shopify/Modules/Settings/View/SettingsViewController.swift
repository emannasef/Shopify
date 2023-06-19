
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var currencyMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currency.text = getCurrency()
     
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
    

    @IBAction func changePassword(_ sender: Any) {
    }
    
    
    @IBAction func chooseCurrency(_ sender: Any) {
    
        let menu = UIMenu(title: "", options: .displayInline, children: setCueencies())
        
       currencyMenu.menu = menu
        currencyMenu.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func enapleDarkMode(_ sender: Any) {
        
        let appDelegates = UIApplication.shared.windows.first
        
        if (sender as AnyObject).isOn{
            
            appDelegates?.overrideUserInterfaceStyle = .dark
            return
        }
        
        appDelegates?.overrideUserInterfaceStyle = .light
        return
    }
    
    
    @IBAction func displayappInfo(_ sender: Any) {
    }
}
