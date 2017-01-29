//
//  UIAlertHandler.swift
//  SaitamaService
//
//  Created by Abhinav Mathur on 28/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import Foundation
import UIKit


class UIAlertHandler {
    
    static let sharedInstance = UIAlertHandler()
    
    fileprivate init() {}
    
    func showAlert(_ viewController : UIViewController, title : String, msg : String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)

    }
}
