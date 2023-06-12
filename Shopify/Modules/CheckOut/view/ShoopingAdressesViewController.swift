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
        adressTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return viewModel.adresses.count
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = adressTable.dequeueReusableCell(withIdentifier: "adressCell") as! ShoppingAdressTableViewCell
        let adress = self.viewModel.getAdress(index: indexPath.row)
        self.setCelldata(cell: cell, adress: adress)
        cell.checkAsDefaultBtn.layer.borderWidth = 1
        cell.checkAsDefaultBtn.layer.borderColor = UIColor.black.cgColor
        cell.checkAsDefaultBtn.layer.cornerRadius = 5
        if cell.checkAsDefaultBtn.isSelected{
           // setAsDefault(cell: cell)
            viewModel.addAdressAsDefault(adress: adress)
            adressTable.reloadData()
        }
        if !ischeckedAsDefault(cell: cell){
            cell.checkAsDefaultBtn.backgroundColor = UIColor.white
        }
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
    
    func ischeckedAsDefault(cell:ShoppingAdressTableViewCell) -> Bool{
        
        if cell.street.text == viewModel.getDefaultAdress().address1{
            
            return true
        }
       return false
    }
  
    func setAsDefault(cell:ShoppingAdressTableViewCell){
        if !ischeckedAsDefault(cell: cell){
            cell.checkAsDefaultBtn.backgroundColor = UIColor.black
            cell.checkAsDefaultBtn.tintColor = UIColor.white
            cell.checkAsDefaultBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
           
        }
      
    }
    
    @IBAction func addAdress(_ sender: Any) {
    }
}
