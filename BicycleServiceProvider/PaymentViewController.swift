//
//  PaymentViewController.swift
//  BicycleServiceProvider
//
//  Created by Abhinav Mathur on 29/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import UIKit
import Alamofire

class PaymentViewController: XLFormViewController {
    
    // MARK: - IBOUtlets
    
    @IBOutlet weak var buttonRent: UIBarButtonItem!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeForm()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func tapOnPay(_ sender: Any) {
        
        let valuesDictionary = form.formValues()
        var name        : String?
        var cardNumber  : String?
        var cvv         : String?
        if (valuesDictionary["name"] as AnyObject).description == "<null>"
        {
            name = ""
        }
        else
        {
            name = valuesDictionary["name"] as? String
        }
        if (valuesDictionary["card"] as AnyObject).description == "<null>"
        {
            cardNumber = ""
        }
        else
        {
            cardNumber = valuesDictionary["card"] as? String
        }
        if (valuesDictionary["code"] as AnyObject).description == "<null>"
        {
            cvv = ""
        }
        else
        {
            cvv = String(valuesDictionary["code"] as! Int)
        }
        let expiry = (valuesDictionary["expiry"] as! NSDate).description
        
        print("\(name) \(cardNumber) \(expiry) \(cvv)")
        
        // Check empty fields
        if(name!.isEmpty || cardNumber!.isEmpty || expiry.isEmpty || cvv!.isEmpty){
            
            UIAlertHandler.sharedInstance.showAlert(self, title: "Validation Error", msg: "One or more fields are empty")
            return
        }
        // Check Card Lenght
        if(cardNumber!.characters.count < 16 || cardNumber!.characters.count  > 16){
            UIAlertHandler.sharedInstance.showAlert(self, title: "Validation Error", msg: "Invalid Card Number")
            return
        }
        // Check no alphabets in card number
        let unwantedCharacters = NSCharacterSet.decimalDigits.inverted//decimalDigitCharacterSet.invertedSet
        
        if(cardNumber!.rangeOfCharacter(from: unwantedCharacters) != nil) {
            UIAlertHandler.sharedInstance.showAlert(self, title: "Validation Error", msg: "Non numerical value in Card Number")
            return
        }
        // Validate the CVV
        if(cvv!.rangeOfCharacter(from: unwantedCharacters) != nil){
            UIAlertHandler.sharedInstance.showAlert(self, title: "Validation Error", msg: "CVV Number contain non numeric value.")
            return
        }
        
        
        let cardParameters = ["number" : cardNumber!, "name" : name!, "expiration" : expiry, "code": cvv!] as Dictionary<String, String>
        let endPoint: String = UrlConstants.serverHost + UrlConstants.paymentUrl //"http://localhost:8080/api/v1/rent"
        let headers = ["Authorization": AccessToken.sharedInstance.getAccessToken()!,"Accept": "application/json"]
        Alamofire.request(endPoint, method: .post, parameters: cardParameters, headers: headers)
            .responseJSON { response in
                guard response.result.error == nil else {
                    UIAlertHandler.sharedInstance.showAlert(self, title: "Error Connecting", msg: (response.result.error?.localizedDescription)!)
                    return
                }
                
                if let value = response.result.value {
                    let res = JSON(value)
                    
                    let alertController = UIAlertController(title: "Success", message: res["message"].stringValue, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion:nil)
                }
        }
    }
    
    // Create Form
    private func initializeForm() {
        
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor

        form = XLFormDescriptor(title: "Payment Details")

        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)

        // Title
        row = XLFormRowDescriptor(tag: "name", rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "Name"
        section.addFormRow(row)
        
        // Description
        row = XLFormRowDescriptor(tag: "card", rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "Card"
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "expiry", rowType: XLFormRowDescriptorTypeDate)
        row.title = "Expiry"
        row.value = NSDate()
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "code", rowType: XLFormRowDescriptorTypeInteger)
        row.title = "CVV"
        section.addFormRow(row)
        
        self.form = form

    }
    
}

