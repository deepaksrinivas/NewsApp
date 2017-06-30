//
//  StarterProjectTests.swift
//  StarterProjectTests
//
//  Created by Srinivas, Deepak - Deepak on 6/30/17.
//
//

import XCTest
@testable import StarterProject

class StarterProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainStoryboard() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        NewsSourcesViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(storyboard, "Main storyboard has been deleted or changed by name")
        
        availableViewControllersTest(storyboard: storyboard)
    }
    
    func availableViewControllersTest(storyboard: UIStoryboard) {
        let initialController = storyboard.instantiateInitialViewController()
        XCTAssertNotNil(initialController, "Initial Controller cannot be nil. Please check storyboard for the fix")
        if initialController != nil {
            XCTAssertTrue(initialController!.isKind(of: UINavigationController.self), "Initial Controller must be navigation controller in storyboard")
        }
        
        let newsSourcesController = (initialController as? UINavigationController)?.topViewController as? NewsSourcesViewController
        XCTAssertNotNil(newsSourcesController, "NewsSourcesViewController must be the root view controller of navigation controller")
        
        let newsArticlesController = storyboard.instantiateViewController(withIdentifier: "NewsArticlesViewController") as? NewsArticlesViewController
        XCTAssertNotNil(newsArticlesController, "NewsArticlesViewController must be present in storyboard along with identifier")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
