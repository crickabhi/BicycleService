//
//  BicycleServiceProviderTests.swift
//  BicycleServiceProviderTests
//
//  Created by Abhinav Mathur on 29/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import XCTest
@testable import BicycleServiceProvider

class BicycleServiceProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let exampleViewController = mainStoryboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func loginValidator(){
        XCTAssert(true)
    }
    
}
