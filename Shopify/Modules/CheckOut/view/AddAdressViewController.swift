
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
    
    @IBOutlet weak var regionMenue: UIButton!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var zipCode: UITextField!
   
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var addAdressBtn: UIButton!
    @IBOutlet weak var countryMenu: UIButton!
    @IBOutlet weak var phoneNumView: UIView!
    var adressToBeUpdated : PostedAdress?
    var staus : String!
    var choosedCountry : String!
    var viewModel : AdressViewModel!
    var network : Network!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setViewsCorners()
        network = Network()
        viewModel = AdressViewModel(network: network)
        setFieldWithData()
       
    }
    
    func setViewsCorners(){
        nameView.layer.cornerRadius = 20.0
        adressView.layer.cornerRadius = 20.0
        cityView.layer.cornerRadius = 20.0
        regionView.layer.cornerRadius = 20.0
        countryView.layer.cornerRadius = 20.0
        zipCodeView.layer.cornerRadius = 20.0
        phoneNumView.layer.cornerRadius = 20.0
    }
    
    
    func setAdressObj() -> (UploadAdress,UpdatedAdressRequest){
     
        let customerName = splitFullName(name: customerName.text ?? "")
        _ = customerName.0
        _ =  customerName.1
        let fullName = self.customerName.text ?? ""
        let city = city.text
        let region = region.text
        let country = country.text
        var adress = PostedAdress(id: adressToBeUpdated?.id ?? 0, name: fullName , city: city ?? "", region: region ?? "", countryName: country ?? "Not found", phone: phoneNum.text ?? "", zip: zipCode.text ?? "")
        adress.default = false
        let uploadAdress = UploadAdress(address: adress)
        let updatedAdress = PostedAdress(id: adressToBeUpdated?.id ?? 0, name: fullName , city: city ?? "", region: region ?? "", countryName: country ?? "Not found", phone: phoneNum.text ?? "", zip: zipCode.text ?? "")
        let updatedAdressReq = UpdatedAdressRequest(address: updatedAdress)
        return (uploadAdress,updatedAdressReq)
    }

    @IBAction func chooseCountryBtn(_ sender: Any) {

            let menu = UIMenu(title: "Countries", options: .displayInline, children: setCountries())
            
            countryMenu.menu = menu
            countryMenu.showsMenuAsPrimaryAction = true
        }
        
    
    @IBAction func chooseProvenice(_ sender: Any) {
        let menu = UIMenu(title: "Regions", options: .displayInline, children: setProvenices())
        
        regionMenue.menu = menu
        regionMenue.showsMenuAsPrimaryAction = true
        
    }
    
    func setFieldWithData(){
        
        if staus == "edit" {
            addAdressBtn.titleLabel?.text = "UPDATE ADDRESS"
            customerName.text = adressToBeUpdated?.name
            city.text = adressToBeUpdated?.city
            region.text = adressToBeUpdated?.province
            country.text = adressToBeUpdated?.countryName
            phoneNum.text = adressToBeUpdated?.phone
            zipCode.text = adressToBeUpdated?.zip
        }
    }
    
    func setCountries() -> [UIAction]{
         
        var list : [UIAction]! = []
        for con in countries{
           
            let country = UIAction(title: con) { (action) in
                self.country.text = con
              
             }
            list.append(country)
        }
        return list
    }

    
    func setProvenices() -> [UIAction]{
         
        var list : [UIAction]! = []
        for prov in provenices{
           
            let provniece = UIAction(title: prov) { (action) in
                self.region.text = prov
              
             }
            list.append(provniece)
        }
        return list
    }
    
    @IBAction func saveAdress(_ sender: Any) {
        
        let customerId  = Int(UserDefaults.standard.string(forKey: "customerId")!)
        if staus == "add"{
            viewModel .addAdress(adress: setAdressObj().0,customerId: customerId ?? 0 )
            print("added............")
        }
        else {
            
            viewModel.updateSdress(adress: setAdressObj().1,customerId: customerId ?? 0)
            print("updated...........")
           /* if adressToBeUpdated != setAdressObj().1.address{
                viewModel.updateSdress(adress: setAdressObj().1,customerId: 7046569754933)
                print("updated...........")
            /Users/mac/Desktop/MergedShopify 3/Shopify/ToastMessage            }
            else {
                createToastMessage(message: "There is no updates",view: self.view)
            }*/
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
}


