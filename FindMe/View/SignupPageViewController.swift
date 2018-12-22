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
    
    lazy var signupViewModel : SignupPageViewModel = {
        return SignupPageViewModel()
    }()
    
    @objc func resignFirstResponders(){
        self.passWordTextField.resignFirstResponder()
        self.userNameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.reEnterPasswordTextField.resignFirstResponder()
    }
    
    
    @IBAction func profilePicTapGestureAction(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType =  .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        resignFirstResponders()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        self.signupViewModel.signUp(name: userNameTextField.text, email: emailTextField.text, password: passWordTextField.text, renteredPassword: reEnterPasswordTextField.text, profileImage: profileImageView.image) { (user) in
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.findMeTextLabel.textColor = self.view.tintColor
        
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = CGFloat(85 * 0.5)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resignFirstResponders)))
        
        self.passWordTextField.isSecureTextEntry = true
        self.reEnterPasswordTextField.isSecureTextEntry = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SignupPageViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("not working")
            return
        }
        
        self.profileImageView.image = image
    }
    
}

extension SignupPageViewController : UINavigationControllerDelegate{
    
}







