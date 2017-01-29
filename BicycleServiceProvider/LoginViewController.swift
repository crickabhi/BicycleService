//
//  LoginViewController.swift
//  BicycleServiceProvider
//
//  Created by Abhinav Mathur on 29/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Interface Builder Actions
    
    @IBAction func tappedSignIn(sender: AnyObject) {
        
        let userEmail = textEmail.text!
        let userPassword = textPassword.text!
        
        // Validate the data
        if(userEmail.isEmpty || userPassword.isEmpty){
            UIAlertHandler.sharedInstance.showAlert(self, title: "Validation Error", msg: "Please enter both email and password details.")
            return
        }
        let requestUrl = UrlConstants.serverHost + UrlConstants.authenticationUrl//"http://localhost:8080/api/v1/auth"
        // Login Call
        let loginParameters = ["email" : userEmail, "password" : userPassword]
        Alamofire.request(requestUrl, method: .post, parameters: loginParameters)

            .responseJSON { response in
                guard response.result.error == nil else {
                    UIAlertHandler.sharedInstance.showAlert(self, title: "Error In Connection", msg: (response.result.error?.localizedDescription)!)
                    return
                }
                if let value = response.result.value {
                    let res = JSON(value)
                    let access = res["accessToken"].stringValue
                    
                    if(access.isEmpty){
                        UIAlertHandler.sharedInstance.showAlert(self, title: "Error", msg: "Invalid Credentials, Please try again.")
                    }
                    else{
                        AccessToken.sharedInstance.setAccessToken(access)
                        DispatchQueue.main.async(execute: { () -> Void in
                            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
                            self.present(viewController, animated: true, completion: nil)
                        })
                    }
                }
        }
    }
    
    @IBAction func tappedSignUp(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUp")
        self.present(viewController, animated: true, completion: nil)
    }
}
