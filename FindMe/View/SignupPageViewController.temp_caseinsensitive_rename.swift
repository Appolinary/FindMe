//
//  SignUpPageViewController.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-20.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import UIKit

class SignupPageViewController: UIViewController {
    
    @IBOutlet weak var findMeTextLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passWordTextField: UITextField!
    
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func profilePicTapGestureAction(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.findMeTextLabel.textColor = self.view.tintColor
        
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = CGFloat(85 * 0.5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
