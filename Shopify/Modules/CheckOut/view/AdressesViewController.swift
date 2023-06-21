//
//  AdrTableViewController.swift
//  Shopify
//
//  Created by Mac on 18/06/2023.
//

import UIKit

class AdressesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var adressTable: UITableView!
    @IBOutlet weak var addAdressBtn: UIButton!
    var viewModel : AdressViewModel!
    var network : Network!
    var id : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        id  = Int(UserDefaults.standard.string(forKey: "customerId") ?? "") ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        adressTable.reloadData()
        network = Network()
        viewModel = AdressViewModel(network: network)
        viewModel.bindAdressesToViewController = { [weak self] in
            DispatchQueue.main.async{
                self?.adressTable.reloadData()
                print("Data saved")
            }
            
        }
    
        viewModel.getCustomerAdresses(customerId: 7046569754933)
        
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.getCountOfAdress() ?? 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = adressTable.dequeueReusableCell(withIdentifier: "adressCell") as! ShoppingAdressTableViewCell
        var adress = self.viewModel.getAdress(index: indexPath.section)
        getAsDefault(adress: adress, cell: cell)
        self.setCelldata(cell: cell, adress: adress)
        cell.bindAdressToBeUodated = { [weak self] in
           
            self?.setEditBtnAction(adress: adress)
            
        }
        cell.setDefaultAction = {
            print("set default btn pressed .............")
           // self.viewModel.setAdressAsDefault(adress: adress,customerId:7037983686965 , adressId: adress.id ?? 0)
            self.setDefaultadress(adress: adress)
            self.viewModel.getCustomerAdresses(customerId: 7046569754933)
            self.getAsDefault(adress: adress, cell: cell)
        }
        cell.checkAsDefaultBtn.layer.borderWidth = 1
        cell.checkAsDefaultBtn.layer.borderColor = UIColor.black.cgColor
        cell.checkAsDefaultBtn.layer.cornerRadius = 5
      
        return cell
    }

    func setEditBtnAction(adress:PostedAdress){
        
        let updateAdressVc = self.storyboard?.instantiateViewController(identifier: "addAdressScreen") as! AddAdressViewController
        updateAdressVc.adressToBeUpdated = adress
        updateAdressVc.staus = "edit"
        self.navigationController?.pushViewController(updateAdressVc, animated: true)
        
    }
    
    func setCelldata(cell:ShoppingAdressTableViewCell,adress:PostedAdress){
        
        cell.userName.text = adress.name
        cell.city.text = adress.city
        cell.street.text = adress.address1
        cell.layer.cornerRadius = 8
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
 
  
    func getAsDefault(adress:PostedAdress,cell:ShoppingAdressTableViewCell){
        if adress.default == true{
           cell.checkAsDefaultBtn.backgroundColor = UIColor.black
            cell.checkAsDefaultBtn.tintColor = UIColor.white
            cell.checkAsDefaultBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
           
        }
        else {
            print("from else")
            cell.checkAsDefaultBtn.backgroundColor = UIColor.white
        }
      
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        let adressTobeDeleted = viewModel.getAdress(index: indexPath.section)
       if editingStyle == .delete {
           
           let alert = UIAlertController(title: "Confirmation!", message: "Remove Adress..?", preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self]_ in
               if adressTobeDeleted.default != true{
                   self.viewModel.deleteAdress(customerId: adressTobeDeleted.customerId ?? 0, adressId: adressTobeDeleted.id ?? 0, address: adressTobeDeleted)
                   self.viewModel.adresses?.remove(at: indexPath.section)
                   tableView.deleteSections([indexPath.section], with: .top)
               }
               else {
                   
                   createToastMessage(message: "You can't delete your default Address",view: self.view)
                   
               }
              
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{_ in
               alert.dismiss(animated: true)
           }))
           
           self.present(alert, animated: true, completion: nil)
          
       }
   }
    func setDefaultadress(adress:PostedAdress){
       
        var updatedAdressReq = UpdatedAdressRequest(address: adress)
        updatedAdressReq.address?.default = true
        viewModel.updateSdress(adress: updatedAdressReq, customerId: adress.customerId ?? 0)
    }
    
    
    @IBAction func addAdress(_ sender: Any) {
        
        let addAdressVc = self.storyboard?.instantiateViewController(identifier: "addAdressScreen") as! AddAdressViewController
        addAdressVc.staus = "add"
        self.navigationController?.pushViewController(addAdressVc, animated: true)
        
    }
}
