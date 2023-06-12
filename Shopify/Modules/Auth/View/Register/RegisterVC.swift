//
//  RegisterVC.swift
//  ShopifyUser
//
//  Created by Mac on 08/06/2023.
//

import UIKit

class RegisterVC: UIViewController {
  
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var confirmPasswordCheck :String?
    var customer:Customer = Customer()
    var registerViewModel = RegisterViewModel(network: Network())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        customer.first_name = name.text
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
                        
                        self?.showToast(message: "Account Created", seconds: 2.0)
                        
                       // let hhVC = self?.storyboard?.instantiateViewController(withIdentifier: "Hh") as! Hh
                        
                      //  hhVC.modalPresentationStyle = .fullScreen
                       // self?.present(hhVC , animated: true, completion: nil)
                        
                        UserDefaults.standard.set(self?.customer.id, forKey: "customerId")
                        UserDefaults.standard.set(self?.customer.first_name, forKey: "customerName")
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        
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
        
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC , animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
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


