//
//  RegisterVC.swift
//  ShopifyUser
//
//  Created by Mac on 08/06/2023.
//

import UIKit
import GoogleSignIn
import FacebookLogin

class RegisterVC: UIViewController {
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var confirmPasswordCheck :String?
    var customer:Customer = Customer()
    var registerViewModel = RegisterViewModel(network: AuthNetwork())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        customer.firstName = name.text
        customer.email = email.text
        customer.tags = password.text
        confirmPasswordCheck = confirmPassword.text
        
        
        if password.text!.isPasswordContainsLettersAndNumbers == false {
            self.showToast(message: "Password must Minimum 8 characters at least 1 Alphabet and 1 Number", seconds: 2.0)
        }else{
            
            if customer.tags == confirmPasswordCheck{
                
                registerViewModel.registerCustomer(customer: customer)
            }
            else{
                showToast(message: "not matches Password", seconds: 2.0)
            }
            
            
            registerViewModel.bindingSignUp = { [weak self] in
                DispatchQueue.main.async {
                    
                    if self?.registerViewModel.statusCode  == 201{
                        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "mainVC") as! UITabBarController
                        self?.navigationController?.pushViewController(mainTabBarController, animated: true)
                        
                    } else if self?.registerViewModel.statusCode == 422{
                        self?.showToast(message: "Already Exist", seconds: 2.0)
                    }
                    else{
                        self?.showToast(message: "Check your Data", seconds: 2.0)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(loginVC, animated: true)
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
    
    @IBAction func signUpGoogle(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: self) { signInResult, error in
                guard let result = signInResult else {
                    // Inspect error
                    return
                }
                // If sign in succeeded, display the app's main content View.
                let user = result.user
                self.customer.email = user.profile?.email
                self.customer.firstName = user.profile?.name
                self.customer.tags = user.profile?.email
   
                
                self.registerViewModel.registerCustomer(customer: self.customer)
                
                let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "mainVC") as! UITabBarController
                self.navigationController?.pushViewController(mainTabBarController, animated: true)
            }
        
    }
    
    
    
}


