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
                        print("Suceeeeeeeesssss")
                        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "mainVC") as! UITabBarController
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                        
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
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        
    }
    
    
    @IBAction func signUpFacebook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile","email"], from: self, handler: { result, error in
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                    
                } else {
                    print("Cancelled")
                }
            }
        })
    }
    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
        graphRequest.start { _, result, error in
            if error == nil {
                let data: [String: AnyObject] = result as! [String: AnyObject]
                var faceEmail = ""
                var faceFirstname = ""
                //var faceId = ""
                //                    if let facebookId = data["id"] as? String {
                //                       faceId = facebookId
                //                    } else {
                //                        print("Facebook Id: Not exists")
                //                    }
                if let facebookFirstName = data["first_name"] as? String {
                    print("Facebook First Name: \(facebookFirstName)")
                    faceFirstname = facebookFirstName
                } else {
                    print("Facebook First Name: Not exists")
                }
                if let facebookEmail = data["email"] as? String {
                    print("Facebook Email: \(facebookEmail)")
                    faceEmail = facebookEmail
                } else {
                    print("Facebook Email: Not exists")
                }
                
                self.customer.email = faceEmail
                self.customer.firstName = faceFirstname
                self.customer.tags = faceEmail
                
                self.registerViewModel.registerCustomer(customer: self.customer)
                
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }
    
    
    
}


