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
        UserDefaults.standard.set("guest", forKey: "UserType")
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "mainVC") as! UITabBarController
        navigationController?.pushViewController(mainTabBarController, animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
}

