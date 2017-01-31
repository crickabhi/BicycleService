//
//  BicycleServiceProviderUITests.swift
//  BicycleServiceProviderUITests
//
//  Created by Abhinav Mathur on 29/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import XCTest

class BicycleServiceProviderUITests: XCTestCase {
   
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin() {
        
        let app = XCUIApplication()
        app.textFields["Email"].tap()
        //app.textFields["Email"]
        app.secureTextFields["Password"].tap()
        //app.secureTextFields["Password"]
        app.buttons["LOGIN"].tap()
        
    }
    
    func testRegistration(){
        
        let app = XCUIApplication()
        app.buttons["SIGN UP"].tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        //app.textFields["Email"]
        emailTextField.tap()
        app.secureTextFields["Password"].tap()
        //app.secureTextFields["Password"]
        app.buttons["SUBMIT"].tap()
        
    }
    
    func testPayment(){
        
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Rentals").children(matching: .other).element.children(matching: .other).element.tap()
        app.sheets.buttons["Yes"].tap()
        app.textFields["Name"].tap()
        //app.textFields["Name"]
        app.textFields["Card"].tap()
        //app.textFields["Card Number"]
        app.pickers["Expiry"].tap()
        let cvvTextField = app.textFields["code"]
        cvvTextField.tap()
        app.buttons["Done"].tap()
        cvvTextField.tap()
        //app.textFields["CVV"]
        app.navigationBars["Payment"].buttons["Pay"].tap()
        
        let okButton = app.alerts["Success"].collectionViews.buttons["OK"]
        okButton.tap()
        
    }
    
}
