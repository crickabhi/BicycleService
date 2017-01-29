//
//  PaymentDetails.swift
//  SaitamaService
//
//  Created by Abhinav Mathur on 28/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import Foundation

class PaymentDetails {
    
    var card : String
    var name : String
    var code : String
    var expiry : String
    
    init?(card: String, name: String, code: String, expiry: String){
        
        self.card = card
        self.name = name
        self.code = code
        self.expiry = expiry
        
        if(card.isEmpty || name.isEmpty || code.isEmpty || expiry.isEmpty){
            return nil
        }
    }
    
    // Creates JSON Object
    
    func getJSON() -> JSON {
        
        return JSON(["card":card, "name": name, "code":code, "expiry": expiry])
    }
}

