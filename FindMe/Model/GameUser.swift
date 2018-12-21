//
//  User.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-20.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation

struct GameUser{
    
    var name : String
    var email : String
    var uid : String
    var profileUrlString : String
    
    func returnAsDictionary() -> [String : String] {
        var dict : [String : String] = [:]
        
        dict[CONSTANTS.BACKEND_USER_NAME_KEY] = name
        dict[CONSTANTS.BACKEND_USER_EMAIL_KEY] = email
        dict[CONSTANTS.BACKEND_USER_PROFILEPHOTO_KEY] = profileUrlString
        
        return dict
    }
}
