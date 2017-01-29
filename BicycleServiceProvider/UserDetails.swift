//
//  UserDetails.swift
//  SaitamaService
//
//  Created by Abhinav Mathur on 28/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import Foundation

class UserDetails {
    
    var userEmail : String
    var userPassword : String
    
    init?(userEmail: String, userPassword: String){
        
        self.userEmail = userEmail
        self.userPassword = userPassword
        
        if(userEmail.isEmpty || userPassword.isEmpty){
            return nil
        }
    }
    
    // Creates JSON Object
    
    func getJSON() -> JSON {
        return JSON(["email":userEmail, "password": userPassword])
    }
}
