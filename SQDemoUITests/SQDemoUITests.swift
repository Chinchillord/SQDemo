//
//  SQDemoUITests.swift
//  SQDemoUITests
//
//  Created by Ben Patterson on 2/4/25.
//

import XCTest

final class SQDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let app = XCUIApplication()
    
    lazy var counter = app.staticTexts.firstMatch
    lazy var addButton = app.buttons["Add"]
    lazy var subtractButton = app.buttons["Subtract"]
    lazy var resetButton = app.buttons["Reset"]

    func testIncrement() throws {
        app.launch()
        _ = addButton.waitForExistence(timeout: TimeInterval(10))
        addButton.tap()
        addButton.tap()
        XCTAssertEqual(counter.label, "2")
    }
    
    func testDecrement() throws {
        app.launch()
        _ = addButton.waitForExistence(timeout: TimeInterval(10))
        addButton.tap()
        addButton.tap()
        subtractButton.tap()
        XCTAssertEqual(counter.label, "1")
    }
    
    func testReset() {
        app.launch()
        _ = addButton.waitForExistence(timeout: TimeInterval(10))
        addButton.tap()
        addButton.tap()
        resetButton.tap()
        XCTAssertEqual(counter.label, "0")
    }
}
