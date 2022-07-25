//
//  Task1VM.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 19/07/22.
//

import Foundation

class LoginVM {
    
    let loginUtility = DBUtility.instance
    
    func saveDetails(email: String, password: String)
    {
        loginUtility.saveUserDetails(email: email, username: password)
    }
    
    func getDetails(completion: @escaping (Details) -> Void){
        
        loginUtility.getUserDetails { details in
            completion(details)
        }
    }
}
