//
//  SignInPageViewModel.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-21.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation

class SigninPageViewModel{
    
    private var signinPageView : SigninPageViewController
    
    init(signinpageview : SigninPageViewController) {
        signinPageView = signinpageview
    }
    
    
    func signin(email : String , password : String, withCompletion : @escaping (GameUser?) -> ()){
        
        BackendServices.Instance().userSigninAction(email: email, password: password) { (user) in
            withCompletion(user)
        }
    }
    
    func signup(userName : String , email : String, password : String, withCompletion :@escaping (GameUser?) -> ()){
        BackendServices.Instance().userSignupAction(name: userName, email: email, password: password) { (user) in
            withCompletion(user)
        }
    }
    
    func showSignUpPage(){
        self.signinPageView.performSegue(withIdentifier: CONSTANTS.SIGNIN_TO_SIGNUP_PAGE_SEGUE_IDENTIFIER, sender: signinPageView)
    }
    
    func resignFirstResponders(){
        self.signinPageView.resignFirstResponder()
    }
}
