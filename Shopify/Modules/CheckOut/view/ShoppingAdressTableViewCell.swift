//
//  TableViewCell.swift
//  Shopify
//
//  Created by Mac on 18/06/2023.
//

import UIKit

class ShoppingAdressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var checkAsDefaultBtn: UIButton!
    var bindAdressToBeUodated : (()-> ())?
    var viewModel : AdressViewModel!
    var network : Network!
    var setDefaultAction : (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        network = Network()
        viewModel = AdressViewModel(network: network)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    @IBAction func editAdress(_ sender: Any) {
        self.bindAdressToBeUodated!()
    }
    
    @IBAction func setAsDefaultBtn(_ sender: Any) {
        
        self.setDefaultAction!()
        
    }
}
