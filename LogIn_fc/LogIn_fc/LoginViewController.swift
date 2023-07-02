//
//  LoginViewController.swift
//  LogIn_fc
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet var emailLoginButton: UIButton!
    @IBOutlet var googleLoginButton: UIButton!
    @IBOutlet var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        //google Sign In
        
    }
    
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
    
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: Any) {
    }
}
