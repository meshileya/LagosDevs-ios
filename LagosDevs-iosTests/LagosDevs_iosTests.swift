//
//  LagosDevs_iosTests.swift
//  LagosDevs-iosTests
//
//  Created by tech on 21/01/2022.
//

import XCTest
@testable import LagosDevs_ios

class LagosDevs_iosTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let e = expectation(description: "ApiService")
        
        let users = ApiService()
        users.fetchUsersAsync(pageNumber: "-") { result,_,_  in
            XCTAssertNotNil(result, "Available")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
