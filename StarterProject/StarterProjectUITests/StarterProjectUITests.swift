//
//  StarterProjectUITests.swift
//  StarterProjectUITests
//
//  Created by Srinivas, Deepak - Deepak on 6/30/17.
//
//

import XCTest

class StarterProjectUITests: XCTestCase {
        
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
    
//    func testNewsTable() {
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        
//        
//        let app = XCUIApplication()
//        app.collectionViews.staticTexts["Australia's most trusted source of local, national and world news. Comprehensive, independent, in-depth analysis, the latest business, sport, weather and more."].tap()
//        app.navigationBars["ABC News (AU)"].buttons["News"].tap()
//        
//        let newsNavigationBar = app.navigationBars["News"]
//        newsNavigationBar.buttons["Grid"].tap()
//        newsNavigationBar.buttons["Huge"].tap()
//        newsNavigationBar.buttons["List"].tap()
//        
//    }
    
    var scrollEndFrame: CGFloat = 0
    
    func testNewsCollection() {
        let app = XCUIApplication()
        let indicatorCount = app.activityIndicators.count
        if indicatorCount > 0 {
            let collectionCellsPredicate = NSPredicate(format: "count > 0")
            expectation(for: collectionCellsPredicate, evaluatedWith: app.collectionViews.cells, handler: nil)
            waitForExpectations(timeout: 5, handler: nil)
            
            var scrollEnd = true
            while scrollEnd {
                let elementsAvailable = findCollectionCells(for: app)
                if elementsAvailable {
                    scrollTo(position: .bottom, for: app.collectionViews.element)
                    scrollTo(position: .bottom, for: app.collectionViews.element)
                    scrollTo(position: .bottom, for: app.collectionViews.element)
                    scrollTo(position: .bottom, for: app.collectionViews.element)
                } else {
                    scrollEnd = false
                    scrollEndFrame = 0
                }
            }
        } else {
            XCTFail("No activity indicator showing up")
        }
        
//        addUIInterruptionMonitor(withDescription: "") { (alert) -> Bool in
//            return true
//        }
    }
    
    func findCollectionCells(for app: XCUIApplication) -> Bool {
        let cellsCount = app.collectionViews.cells.count
        if cellsCount > 0 {
            for cell in app.collectionViews.cells.allElementsBoundByIndex {
                if cell.isHittable {
                    cell.tap()
                    app.navigationBars.buttons["News"].tap()
                }
            }
            let lastCell = app.collectionViews.cells.element(boundBy: cellsCount - 1)
            let currentScrollEndFrame = lastCell.frame.origin.y + lastCell.frame.size.height
            if scrollEndFrame < currentScrollEndFrame {
                scrollEndFrame = currentScrollEndFrame
                return true
            }
            return false
        } else {
            return false
        }
    }
    
    enum ScrollPosition {
        case top
        case bottom
    }
    
    func scrollTo(position: ScrollPosition, for element: XCUIElement) {
        switch position {
            case .top:
                element.swipeDown()
            case .bottom:
                element.swipeUp()
        }
    }
}
