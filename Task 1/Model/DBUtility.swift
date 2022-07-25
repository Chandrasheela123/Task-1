//
//  DBUtility.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 13/07/22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

import UIKit
struct Details {
    
    var email : String
    var username : String
    
    
    
    // object to dictionary conversion
    func toDict() -> [String : String] {
        ["email" : email, "username" : username]
    }
    
}

class DBUtility {
    
    private init(){}
    
    static let instance = DBUtility()
    
    let dbRef = Database.database().reference()
    let loggedInUser = Auth.auth().currentUser
    
    func saveUserDetails(email: String, username : String){
        
        let loggedInUser = Auth.auth().currentUser
        
        let userDetails = Details(email: email, username: username)
        if let user = loggedInUser {
            dbRef.child("Users").child(user.uid).setValue(userDetails.toDict())
        }
        
    }
    
    func getUserDetails(completionHandler: @escaping (Details) -> Void) {
        // get logged in user
        let loggedInUser = Auth.auth().currentUser
        
        if let user = loggedInUser {
            // read from realtime database
            
            let uNode = dbRef.child("Users").child(user.uid)
            
            uNode.getData { err, snapshot in
                
                if err == nil {
                    
                    let info = snapshot?.value as! Dictionary<String, String>
                    
                    let email = info["email"] ?? ""
                    let username = info["username"] ?? ""
                    
                    
                    let acc = Details(email: email, username: username)
                    
                    completionHandler(acc)
                }
            }
        }
    }
    
    

}






