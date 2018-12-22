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
    
    func signin(email : String? , password : String?, withCompletion : @escaping (GameUser?) -> ()){
        
        guard  let emaill = email, let passwd = password else {
            return
        }
        
        BackendServices.Instance().userSigninAction(email: emaill, password: passwd) { (user) in
            withCompletion(user)
        }
    }
}
