//
//  BicycleServiceProviderPaymentTests.swift
//  BicycleServiceProvider
//
//  Created by Abhinav Mathur on 31/01/17.
//  Copyright © 2017 Abhinav Mathur. All rights reserved.
//

import XCTest
@testable import BicycleServiceProvider

class BicycleServiceProviderPaymentTests: XCTestCase {
    
    var payment: PaymentViewController!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        payment = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Payment") as! PaymentViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func paymentValidator(){
        XCTAssert(true)
    }
}
