//
//  FeedingProgramTest.swift
//  FinalProject
//
//  Created by Mac Owner on 8/20/16.
//
//

import UIKit
import XCTest
import CoreData
import CoreDataService
@testable import FinalProject

class FeedingProgramTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   func testCreateProgramForProperAttributeInsertion() {
        let theName = "Some Feeding Program"
        let theCountry = "Haiti"
        var feedingProgram: FeedingProgram?
        do {
            try feedingProgram = FeedingProgramService.sharedProgramService.createFeedingProgram(theName, country: theCountry)
        }
        catch let error {
            fatalError("Failed to add FeedingProgram: \(error)")
        }
        XCTAssertEqual(theName, feedingProgram!.name, "The name doesn't match the created feedingProgram name")
        XCTAssertEqual(theCountry, feedingProgram!.country, "The name doesn't match the created feedingProgram name")
    }
    
    func testFeedingProgramFetchResultsControllerForSectionsAndObjects() {
        let fetchedResultsController: NSFetchedResultsController? = FeedingProgramService.sharedProgramService.fetchedResultsControllerForProgramsWithDelegate(nil)
        XCTAssertNotEqual(fetchedResultsController?.sections?.count, 0, "There aren't any sections in the fetchedResultsController")
        XCTAssertNotEqual(fetchedResultsController?.fetchedObjects?.count, 0, "There aren't any objects in the fetchedResultsController")
        
    }
    
}