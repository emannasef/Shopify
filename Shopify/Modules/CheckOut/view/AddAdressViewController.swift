//
//  ViewController.swift
//  Shopify
//
//  Created by Mac on 18/06/2023.
//

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
    @IBOutlet weak var addAdressBtn: UIButton!
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
        network = Network()
        viewModel = AdressViewModel(network: network)
        setFieldWithData()
        
    }
    func setAdressObj() -> (UploadAdress,UpdatedAdressRequest){
        
        let customerName = customerName.text
        let city = city.text
        let region = region.text
        var adress = PostedAdress(name: customerName ?? "", city: city ?? "", region: region ?? "")
        adress.default = false
        let uploadAdress = UploadAdress(address: adress)
        let updatedAdress = PostedAdress(id: adressToBeUpdated?.id ?? 0, name: customerName ?? "", city: city ?? "", region: region ?? "", countryName: country.text ?? "Not found", phone: phoneNum.text ?? "", zip: zipCode.text ?? "")
        let updatedAdressReq = UpdatedAdressRequest(address: updatedAdress)
        return (uploadAdress,updatedAdressReq)
    }

    @IBAction func chooseCountryBtn(_ sender: Any) {
        
        
    }
    func setFieldWithData(){
        
        if staus == "edit" {
            addAdressBtn.titleLabel?.text = "UPDATE ADDRESS"
            customerName.text = adressToBeUpdated?.name
            city.text = adressToBeUpdated?.city
            region.text = adressToBeUpdated?.address1
            country.text = adressToBeUpdated?.countryName
            phoneNum.text = adressToBeUpdated?.phone
            zipCode.text = adressToBeUpdated?.zip
        }
        
       
    }
    

    @IBAction func saveAdress(_ sender: Any) {
        
        if staus == "add"{
            viewModel .addAdress(adress: setAdressObj().0,customerId: 7046569754933)
            print("added............")
        }
        else {
            
            viewModel.updateSdress(adress: setAdressObj().1,customerId: 7046569754933)
            print("updated...........")
           /* if adressToBeUpdated != setAdressObj().1.address{
                viewModel.updateSdress(adress: setAdressObj().1,customerId: 7046569754933)
                print("updated...........")
            }
            else {
                createToastMessage(message: "There is no updates",view: self.view)
            }*/
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
}

