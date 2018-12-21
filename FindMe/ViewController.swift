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

class ViewController: UIViewController {
    
    @IBOutlet weak var findMeTitleLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    @IBAction func SignUpGestureRecogniser(_ sender: UITapGestureRecognizer) {
        print("tap")
        self.performSegue(withIdentifier: "showSignupPage", sender: self)
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        print(userNameTextField.text!)
        /*
        
        guard let userName = userNameTextField.text else { return }
        guard let password = passwordTextField.text  else { return }
        
        self.provideSignInInfo(userName: userName, password: password) { (user : GameUser?) in
            
            guard let myUser = user else {return }
            
            
            
        Database.database().reference().child("Users").child(myUser.uid).setValue(myUser.returnAsDictionary(), withCompletionBlock: { (error, ref) in
                
                print("worked")
                
            })
        }
 */
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
    
    func  provideSignInInfo(userName : String, password : String, withCompletion : @escaping (GameUser?) -> ()){
        
        Auth.auth().createUser(withEmail: userName, password: password) { (result, error) in
            guard error == nil else {
                print(error!)
                withCompletion(nil)
                return
            }
            guard let realResult = result else{ withCompletion(nil); return }
            withCompletion(GameUser(name: userName, email: userName, uid: realResult.user.uid))
        }
    }
    func getUserInfo(uid : String, withCompletion : (Bool) -> ()){
        
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            
            
        }
        
        
    }
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}



