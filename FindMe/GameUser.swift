//
//  User.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-20.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation

struct GameUser : Codable{
    
    var name : String
    var email : String
    var uid : String
    
    func returnAsDictionary() -> [String : String] {
        var dict : [String : String] = [:]
        
        dict["name"] = name
        dict["email"] = email
        dict["uid"] = uid
        
        return dict
    }
}
