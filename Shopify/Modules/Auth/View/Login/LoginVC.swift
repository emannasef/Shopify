//
//  LoginVC.swift
//  ShopifyCustomer
//
//  Created by Mac on 08/06/2023.
//

import UIKit
import GoogleSignIn
class LoginVC: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    var loginViewModel = LoginViewModel(network: Network())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(
            withPresenting: self) { signInResult, error in
//                guard let result = signInResult else {
//                    // Inspect error
//                    return
//                }
                //If sign in succeeded, display the app's main content View.
                //let user = result.user
                // self.customer.email = user.profile?.email
                //  self.customer.firstName = user.profile?.name
                //  self.customer.tags = user.profile?.email
                let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "mainVC") as! UITabBarController
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        loginViewModel.bindingLogin = { [weak self] in
            DispatchQueue.main.async {
                
                if self?.loginViewModel.vaildateCustomer(customerEmail: self?.emailTF.text ?? "", customerPasssword: self?.passwordTF.text ?? "") == 1 {
                    let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "mainVC") as! UITabBarController
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                    
                }
                if self?.loginViewModel.vaildateCustomer(customerEmail: self?.emailTF.text ?? "", customerPasssword: self?.passwordTF.text ?? "") == 2{
                    
                    self?.showToast(message: "Invalid email", seconds: 2.0)
                }
                if self?.loginViewModel.vaildateCustomer(customerEmail: self?.emailTF.text ?? "", customerPasssword: self?.passwordTF.text ?? "") == 3{
                    
                    self?.showToast(message: "Uncorrect Password", seconds: 2.0)
                }
                
                
            }
        }
        
        
        loginViewModel.getCustomer()
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC , animated: true, completion: nil)
    }
    
    func showToast(message : String, seconds: Double){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.backgroundColor = .cyan
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}
