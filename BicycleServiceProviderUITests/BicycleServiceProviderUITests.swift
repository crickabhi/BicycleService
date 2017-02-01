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
        
        let testApp = XCUIApplication()
        testApp.textFields["Email"].tap()
        testApp.textFields["Email"].typeText("crossover@crossover.com")
        testApp.secureTextFields["Password"].tap()
        testApp.secureTextFields["Password"].typeText("crossover")
        testApp.buttons["LOGIN"].tap()
        
    }
    
    func testRegistration(){
        
        let testApp = XCUIApplication()
        testApp.buttons["SIGN UP"].tap()
        testApp.textFields["Email"].tap()
        testApp.textFields["Email"].typeText("crossover@crossover.com")
        testApp.secureTextFields["Password"].tap()
        testApp.secureTextFields["Password"].typeText("crossover")
        testApp.buttons["SUBMIT"].tap()
        
    }
}
