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
                
                let emailAddress = user.profile?.email
                
                let fullName = user.profile?.name
                print("IIIIIIDDDDDDDD",user.userID)
                print(emailAddress)
                print(fullName)
                self.showToast(message: "Account Created", seconds: 2.0)
                UserDefaults.standard.set(true, forKey: "isLogin")
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
                    print(result?.token)
                  //  self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                    self.getFBLoggedInUserData()
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
                var email = ""
                var firstname = ""
                var lastname = ""
                
                if let facebookId = data["id"] as? String {
                    print("Facebook Id: \(facebookId)")
                } else {
                    print("Facebook Id: Not exists")
                }
                
                
                if let facebookFirstName = data["first_name"] as? String {
                    print("Facebook First Name: \(facebookFirstName)")
                    firstname = facebookFirstName
                } else {
                    print("Facebook First Name: Not exists")
                }
                
                if let facebookMiddleName = data["middle_name"] as? String {
                    print("Facebook Middle Name: \(facebookMiddleName)")
                } else {
                    print("Facebook Middle Name: Not exists")
                }
                
                
                if let facebookLastName = data["last_name"] as? String {
                    print("Facebook Last Name: \(facebookLastName)")
                    lastname = facebookLastName
                } else {
                    print("Facebook Last Name: Not exists")
                }
                
                
                if let facebookName = data["name"] as? String {
                    print("Facebook Name: \(facebookName)")
                } else {
                    print("Facebook Name: Not exists")
                }
                
                
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                print("Facebook Profile Pic URL: \(facebookProfilePicURL)")
                
                
                if let facebookEmail = data["email"] as? String {
                    print("Facebook Email: \(facebookEmail)")
                    email = facebookEmail
                } else {
                    print("Facebook Email: Not exists")
                }
                
                
                //                    let userdata = SocailLoginUserData(email:email, lastName:lastname, firstName:firstname, socialProfileId: userId,userType: "1",loginBy: "2")
                //                    self.loginPresenter.doSocialRegister(userData: userdata)
                
                print("IDDDDDDDDD", userId)
                print("Emaaaaaal",email)
                print("Naaaame",firstname)
                
                print("Facebook Access Token: \(token?.tokenString ?? "")")
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }
    
    func getFBLoggedInUserData()
    {
     
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, email"])
        graphRequest.start(){
            connection, result, error in
            if let result = result, error == nil {
                print("facebook fetched user: \(result)")
            }
        }
    }
    
}


