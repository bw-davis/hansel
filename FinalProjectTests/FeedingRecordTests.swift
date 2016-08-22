//
//  FeedingRecordTests.swift
//  FinalProject
//
//  Created by Mac Owner on 8/21/16.
//
//
/*****************************************************************************
 **                              IMPORTANT TEST NOTES
 ** I had to keep creating entities in each of my tests becasue I need to be
 ** able to pass them to my createEntitiy functions as well as my results
 ** controller functions.  I tried doing globals but that didn't work.  I just
 ** couldn't think of a good way to do it.  Which is also why I lumped together
 ** the results controller test with the one for my createEntity test
 *****************************************************************************/
import UIKit
import XCTest
import CoreData
import CoreDataService
@testable import FinalProject

class FeedingRecordTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testCreateFeedingRecordForProperAttributeInsertion() {
        var feedingProgram: FeedingProgram?
        var location: Location?
        var kid: Kid?
        var feedingRecord: FeedingRecord?
        let weight = 62.0
        do {
            try feedingProgram = FeedingProgramService.sharedProgramService.createFeedingProgram("Feed", country: "Haiti")
            XCTAssertNotEqual(feedingProgram, nil, "A FeedingProgram was not created")
        }
        catch let error {
            fatalError("Failed to add FeedingProgram: \(error)")
        }
        do {
            try location = LocationService.sharedLocationService.createLocation("Some Location", longitude: 10.0, latitude: 10.0, feedingProgram: feedingProgram!)
        }
        catch let error {
            fatalError("Failed to add FeedingProgram: \(error)")
        }
        do {
            try kid = KidService.sharedKidService.createKid("Benjamin", lastName: "Franklin", age: 100, height: 10, weight: 80, picture: nil, location: location!){}
        }
        catch let error {
            fatalError("Failed to add Kid: \(error)")
        }
        do {
            try feedingRecord = FeedingRecordService.sharedFeedingRecordService.createFeedingRecord(weight, date: NSDate(), notes: "Some Notes", kid: kid!){}
        }
        catch let error {
            fatalError("Failed to add feeding record: \(error)")
        }
        XCTAssertEqual(feedingRecord?.weight, weight, "The records weight should be: \(weight) but instead it is \(feedingRecord?.weight)")
        XCTAssertEqual(feedingRecord?.kid, kid, "The relationship Kid for the feedingRecord doesn't match what was passed to createFeedingRecord()")
        
//FETCH RESULTS CONTROLLER TEST
        
        let fetchedResultsController: NSFetchedResultsController? = FeedingRecordService.sharedFeedingRecordService.fetchedResultsControllerForFeedingRecordWithDelegate(nil, kid: kid)
        
        XCTAssertNotEqual(fetchedResultsController?.sections?.count, 0, "There aren't any sections in the fetchedResultsController")
        XCTAssertNotEqual(fetchedResultsController?.fetchedObjects?.count, 0, "There aren't any objects in the fetchedResultsController")
    }
    
}
