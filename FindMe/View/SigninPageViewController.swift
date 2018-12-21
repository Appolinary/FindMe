//
//  ViewController.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-19.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SigninPageViewController: UIViewController {
    
    @IBOutlet weak var findMeTitleLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    private  lazy var signinPageViewModel : SigninPageViewModel! = {
        return  SigninPageViewModel(signinpageview: self)
    }()
    
    
    @IBAction func SignUpGestureRecogniser(_ sender: UITapGestureRecognizer) {
        self.signinPageViewModel.showSignUpPage()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        guard  let email = userNameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        signinPageViewModel.signin(email: email, password: password) { (user) in
            //TODO: use this info to launch the homepage if the user was able to sign in successfully
            
        }
    }
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
       self.signinPageViewModel.resignFirstResponders()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findMeTitleLabel.textColor = self.view.tintColor
        
        passwordTextField.isSecureTextEntry =  true
        passwordTextField.textAlignment = .center
        userNameTextField.textAlignment = .center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SigninPageViewController : UITextFieldDelegate{
    
}



