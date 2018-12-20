//
//  ViewController.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-19.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var findMeTitleLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        guard let userName = userNameTextField.text else { return }
        guard let password = passwordTextField.text  else { return }
        
        self.provideSignInInfo(userName: userName, password: password) { (pass) in
            if(pass == false){
                print("faile")
                return
            }
            else{
                print("passed")
            }
        }
    }
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
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
    
    func  provideSignInInfo(userName : String, password : String, withCompletion : @escaping (Bool) -> ()){
        
        Auth.auth().createUser(withEmail: userName, password: password) { (result, error) in
            guard error == nil else {
                print(error!)
                withCompletion(false)
                return
            }
            guard let realResult = result else{ withCompletion(false); return }
            print(realResult.user.uid)
            withCompletion(true)
        }
    }
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

