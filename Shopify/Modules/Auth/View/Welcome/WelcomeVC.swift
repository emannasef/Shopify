//
//  WelcomeVC.swift
//  ShopifyUser
//
//  Created by Mac on 08/06/2023.
//

import UIKit

class WelcomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func guest(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
    @IBAction func signUp(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC , animated: true, completion: nil)
        
    }
    
    @IBAction func login(_ sender: Any) {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC , animated: true, completion: nil)
        
    }
    
}

