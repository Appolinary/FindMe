//
//  SignupPageViewModel.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-21.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation
import UIKit

class SignupPageViewModel {
    
    func signUp(name : String? , email : String? , password : String? , renteredPassword : String?, profileImage : UIImage?,  withCompletion : @escaping (GameUser?) -> ()){
        
        
        guard let userName = name , let emaill = email  ,let  firstPass = password , let secondPass = renteredPassword,  firstPass == secondPass, let image = profileImage else {
            withCompletion(nil)
            return
        }
        
        BackendServices.Instance().userSignupAction(name: userName, email: emaill, password: firstPass, profileImage: image) { (user) in
            withCompletion((user))
        }
    }
    
}
