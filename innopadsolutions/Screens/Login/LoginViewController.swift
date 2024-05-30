//
//  LoginViewController.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxt.text = "abc@gmail.com"
        passwordTxt.text = "Pass123$"
        // Do any additional setup after loading the view.
    }

    @IBAction func signInBtn(_ sender: Any) {
        let email = emailTxt.text
        let password = passwordTxt.text
        if email == "" || !isValidEmail(email ?? "")  {
            showAlert(message: "Email is empty or inValid", strtitle: "")
            return
        }else if password == "" || !isValidPassword(password ?? "") {
            showAlert(message: "Password is empty or inValid", strtitle: "")
            return
        }else {
            if email == "abc@gmail.com" && password == "Pass123$" {
                redirectToHome()
            } else {
                showAlert(message: "Wrong Email or Password", strtitle: "")
            }
        }
    }
    
    func redirectToHome(){
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: Storyboard_ID.HomeViewController.rawValue) as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$&*]).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
}

