import UIKit

class ShoopingAdressesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var adressTable: UITableView!
    @IBOutlet weak var addAdressBtn: UIButton!
    var viewModel : AdressViewModel!
    var network : Network!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        network = Network()
        viewModel = AdressViewModel(network: network)
        viewModel.bindAdressesToViewController = { [weak self] in
            DispatchQueue.main.async{
                self?.adressTable.reloadData()
                print("Data saved")
            }
            
        }
        viewModel.getCustomerAdresses(customerId: 7037983686965)
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return viewModel.adresses.count
        return viewModel.getCountOfAdress() ?? 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = adressTable.dequeueReusableCell(withIdentifier: "adressCell") as! ShoppingAdressTableViewCell
        let adress = self.viewModel.getAdress(index: indexPath.section)
        setAsDefault(adress: adress, cell: cell)
        self.setCelldata(cell: cell, adress: adress)
        cell.checkAsDefaultBtn.layer.borderWidth = 1
        cell.checkAsDefaultBtn.layer.borderColor = UIColor.black.cgColor
        cell.checkAsDefaultBtn.layer.cornerRadius = 5
      
        return cell 
    }

    func setCelldata(cell:ShoppingAdressTableViewCell,adress:Adress){
        
        cell.userName.text = adress.name
        cell.city.text = adress.city
        cell.street.text = adress.address1
        cell.layer.cornerRadius = 8
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
 
  
    func setAsDefault(adress:Adress,cell:ShoppingAdressTableViewCell){
        if adress.default == true{
            cell.checkAsDefaultBtn.backgroundColor = UIColor.black
            cell.checkAsDefaultBtn.tintColor = UIColor.white
            cell.checkAsDefaultBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
           
        }
      
    }
    
    @IBAction func addAdress(_ sender: Any) {
    }
}
