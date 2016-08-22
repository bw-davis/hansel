//
//  FinalProjectUITests.swift
//  FinalProjectUITests
//
//  Created by Charles Augustine on 11/4/15.
//
//
/******************************************************************************
 **                         IMPORTANT UI TEST NOTES
 ** The test that fails does so becasue I can't get it to recognize the choose
 ** button from the edit mode of the image picker once the photo has been 
 ** selected.  So the testfCreatedKidIsPresentInViewController() omits it and
 ** saves without it.  Sometimes the tests fail randomly while waiting for
 ** expectationForPredicate()
 *****************************************************************************/
import XCTest
import UIKit
@testable import FinalProject

class FinalProjectUITests: XCTestCase {
        
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
    func testaAddFeedingProgramButton() {
        sleep(3)
        let app = XCUIApplication()
        app.navigationBars["Feeding Programs"].buttons["Add"].tap()
        let navBar = app.navigationBars["Add Program"]
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    func testbCreatedFeedingProgramCellIsPresentInView() {
        sleep(3)
        let app = XCUIApplication()
        app.navigationBars["Feeding Programs"].buttons["Add"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.textFields.containingType(.Button, identifier:"Clear text").element
        app.keyboards.keys["Z"].tap()
        app.buttons["Next:"].tap()
        tablesQuery.textFields["Program Country"].tap()
        tablesQuery.textFields["Program Country"]
        tablesQuery.textFields.containingType(.Button, identifier:"Clear text").element
        app.keyboards.keys["Z"].tap()
        app.navigationBars["Add Program"].buttons["Save"].tap()
        tablesQuery.staticTexts["Z"].tap()
    }
    func testcAddLocationViewControllerAppears() {
        sleep(3)
        let app = XCUIApplication()
        app.tables.staticTexts["Z"].tap()
        app.navigationBars["Z Locations"].buttons["Add"].tap()
        let navBar = app.navigationBars["Add Location"]
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    func testdCreatedLocationIsPresentInView() {
        sleep(3)
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Z"].tap()
        var navBar = app.navigationBars["Z Locations"]
        var existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
        app.navigationBars["Z Locations"].buttons["Add"].tap()
        
        navBar = app.navigationBars["Add Location"]
        existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
        app.textFields["Location Name"]
        app.keyboards.keys["Z"].tap()
        
        app.buttons["Done"].tap()
               app.buttons["Search"].tap()
        app.searchFields["Search"]
        app.keyboards.keys["O"].tap()
        app.keyboards.keys["r"].tap()
        app.keyboards.keys["e"].tap()
        app.keyboards.keys["g"].tap()
        app.keyboards.keys["o"].tap()
        app.keyboards.keys["n"].tap()
        
        app.searchFields["Search"]
        app.keyboards.buttons["Search"].tap()
               app.navigationBars["Add Location"].buttons["Save"].tap()
        tablesQuery.staticTexts["Z"].tap()
    }
    func testeAddKidViewControllerAppears() {
        sleep(3)
        let app = XCUIApplication()
        let zStaticText = app.tables.staticTexts["Z"]
        zStaticText.tap()
        zStaticText.tap()
        app.navigationBars["Locations Kids"].buttons["Add"].tap()
        let navBar = app.navigationBars["Add Kid"]
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
/**************************************************************
** I couldn't get the imagePicker choose button to work at all
** so I omitted that part.  This test fails every so often
** while waiting for an expectation.  It's random.
**************************************************************/
    func testfCreatedKidIsPresentInViewController() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let zStaticText = tablesQuery.staticTexts["Z"]
        zStaticText.tap()
        zStaticText.tap()
        var navBar = app.navigationBars["Locations Kids"]
        var existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
        
        app.navigationBars["Locations Kids"].buttons["Add"].tap()
        navBar = app.navigationBars["Add Kid"]
        existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
        tablesQuery.cells.containingType(.StaticText, identifier:"First Name:").childrenMatchingType(.TextField).element
        app.keyboards.keys["Z"].tap()
        let nextButton = app.buttons["Next:"]
        nextButton.tap()
        
        let tablesQuery2 = tablesQuery
        tablesQuery2.textFields["Last Name"]
        tablesQuery.cells.containingType(.StaticText, identifier:"Last Name:").childrenMatchingType(.TextField).element
        app.keyboards.keys["Z"].tap()
        nextButton.tap()
        tablesQuery2.textFields["Age"]
        tablesQuery.cells.containingType(.StaticText, identifier:"Age:").childrenMatchingType(.TextField).element
        app.keyboards.keys["1"].tap()
        tablesQuery2.textFields["Height"].tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Height in Inches:").childrenMatchingType(.TextField).element
        app.keyboards.keys["1"].tap()
        tablesQuery2.textFields["Weight"].tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Weight:").childrenMatchingType(.TextField).element
        app.keyboards.keys["1"].tap()
        
        app.navigationBars["Add Kid"].buttons["Save"].tap()
        tablesQuery2.staticTexts[" Z  Z"].tap()
    }
    func testgAddFeedingRecordViewControllerAppears() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let zStaticText = tablesQuery.staticTexts["Z"]
        zStaticText.tap()
        zStaticText.tap()
        tablesQuery.staticTexts[" Z  Z"].tap()
        tablesQuery.buttons["Add Feeding Record"].tap()
        let navBar = app.navigationBars["Feeding Record"]
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        expectationForPredicate(existsPredicate, evaluatedWithObject: navBar,
                                handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}
