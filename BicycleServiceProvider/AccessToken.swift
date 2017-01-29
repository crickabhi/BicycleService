//
//  AccessToken.swift
//  SaitamaService
//
//  Created by Abhinav Mathur on 28/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import Foundation

class AccessToken {
    
    static let sharedInstance = AccessToken()
    
    // MARK: - Code to get the access key from Keychain
    
    func setAccessToken(_ accessToken : String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(accessToken, forKey: "AccessTokenKey")
    }
    
    func getAccessToken() -> String? {
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.object(forKey: "AccessTokenKey") as? String
        return accessToken
    }
}
