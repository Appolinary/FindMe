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
    func userSignupAction(name : String , email : String, password : String, profileImage : UIImage,  withCompletion : @escaping (GameUser?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard error == nil , let result = authResult else {
                withCompletion(nil)
                return
            }
            
            var profileUrlString = CONSTANTS.DEFAULT_PROFILE_PHOTO
            
            let imageId = result.user.uid
            
            let ref = Storage.storage().reference().child(CONSTANTS.BACKEND_USERS_PROFIILE_IMAGES_TABLE_NAME).child(imageId)
            
            self.uploadImageStorage(StorageRef: ref, image: profileImage, withCompletion: { (urlString) in
                if let urlString = urlString{
                    profileUrlString = urlString
                }
                
                let user = GameUser(name: name, email: email, uid: result.user.uid, profileUrlString: profileUrlString)
                
                self.updateBackend(reference: Database.database().reference().child(CONSTANTS.BACKEND_USERS_TABLE_NAME).child(result.user.uid).ref, Data: user.returnAsDictionary(), withCompletion: { (pass) in
                    guard pass == true else {
                        withCompletion(nil)
                        return
                    }
                    
                    withCompletion(user)
                })
            })
        }
    }
    private func uploadImageStorage(StorageRef : StorageReference, image : UIImage, withCompletion : @escaping (String?) -> ()){
        
        guard image != #imageLiteral(resourceName: "defaultProfilePhoto") , let data = UIImagePNGRepresentation(image) else {
            withCompletion(nil)
            return
        }
        
        StorageRef.putData(data, metadata: nil) { (metadata, error) in
            guard error == nil else {return}
            
            metadata?.storageReference?.downloadURL(completion: { (url, error) in
                guard error == nil, let url = url else {return }
                withCompletion(url.absoluteString)
            })
        }.resume()
        
    }
    
    //this will be called to update the node at the provided reference with the speicified dictionary
    func updateBackend(reference : DatabaseReference, Data : [String : String] , withCompletion : @escaping (Bool) -> ()){
        reference.updateChildValues(Data) { (error, ref) in
            guard error == nil else{
                withCompletion(false)
                return
            }
            withCompletion(true)
        }
    }
    
}
