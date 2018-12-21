//
//  BackendServices.swift
//  FindMe
//
//  Created by Fabrice Appolinary on 2018-12-21.
//  Copyright © 2018 Fabrice Appolinary. All rights reserved.
//

import Foundation
import Firebase

class BackendServices{
    
    /*
     The database reference in Firebase
     */
    public  var databaseReference : DatabaseReference{
      return  Database.database().reference()
    }
    
    private static var myPrivateInstance = BackendServices()
    
    /*
     This will be used to return the global instance of the backend object
     */
    static func Instance() -> BackendServices{
        return myPrivateInstance
    }
    private init(){
        
    }
    
    //facilitates sign in action of user
    func userSigninAction(email : String , password : String , withCompletion : @escaping (GameUser?) -> ()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard error == nil, let result = authResult else {
                withCompletion(nil)
                return
            }
        self.databaseReference.child(CONSTANTS.BACKEND_USERS_TABLE_NAME).child(result.user.uid).observe(DataEventType.value, with: { (snapshot) in
                
                guard let snap = snapshot.value as? [String : Any], let name = snap[CONSTANTS.BACKEND_USER_NAME_KEY] as? String,
                    let email = snap[CONSTANTS.BACKEND_USER_EMAIL_KEY] as? String,
                    let  profileUrlString = snap [CONSTANTS.BACKEND_USER_PROFILEPHOTO_KEY] as? String else{
                        withCompletion(nil)
                        return
                }
                let user = GameUser(name: name, email: email, uid: result.user.uid, profileUrlString: profileUrlString)
                withCompletion(user)
            })
        }
    }
    
    //facilitates  sign up action of user
    func userSignupAction(name : String , email : String, password : String, withCompletion : @escaping (GameUser?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard error == nil , let result = authResult else {
                withCompletion(nil)
                return
            }
            
            /*
             TODO:
               1. check if the profile image is different from the template image
               2. if so then push the image to firebase storage and get the url of its new location
               3. if not then just set the profileURl to some default string eg. empty profile pic
               4. otherwise then create the game user object and push that to the users' node in firebase
               5. send the new user object to the caller of this object
             */
            
            let profileUrlString = CONSTANTS.DEFAULT_PROFILE_PHOTO // TODO : depends if the profile pic was set
            
            let user = GameUser(name: name, email: email, uid: result.user.uid, profileUrlString: profileUrlString)
            
            self.updateBackend(reference: self.databaseReference.child(CONSTANTS.BACKEND_USERS_TABLE_NAME).child(result.user.uid), Data: user.returnAsDictionary(), withCompletion: { (pass) in
                guard pass == true else {
                    withCompletion(nil)
                    return
                }
                
                withCompletion(user)
            })
        }
        
    }
    
    //this will be called to update the node at the provided reference with the speicified dictionary
    func updateBackend(reference : DatabaseReference, Data : [String : Any] , withCompletion : @escaping (Bool) -> ()){
        reference.updateChildValues(Data) { (error, ref) in
            guard error == nil else{
                withCompletion(false)
                return
            }
            withCompletion(true)
        }
    }
    
}
