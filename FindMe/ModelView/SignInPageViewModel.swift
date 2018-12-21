//
//  SignInPageViewModel.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-21.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation

class SigninPageViewModel{
    
    private static let privateInstance = SigninPageViewModel()
    
    public static func Instance() -> SigninPageViewModel {
        return privateInstance
    }
    
    private init(){
        
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
}
