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
        self.performSegue(withIdentifier: CONSTANTS.SIGNIN_TO_SIGNUP_PAGE_SEGUE_IDENTIFIER, sender: signinPageViewModel)
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        signinPageViewModel.signin(email: userNameTextField.text, password: passwordTextField.text) { (user) in
            //TODO: use this info to launch the homepage if the user was able to sign in successfully
            
        }
    }
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        self.passwordTextField.resignFirstResponder()
        self.userNameTextField.resignFirstResponder()
        
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

extension SignupPageViewController : UITextFieldDelegate{
    
}



