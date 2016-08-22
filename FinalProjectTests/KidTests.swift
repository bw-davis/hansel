//
//  KidTests.swift
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

class KidTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testCreateLocationForProperAttributeInsertion() {
        var feedingProgram: FeedingProgram?
        var location: Location?
        var kid: Kid?
        let firstName = "Kenny"
        let lastName = "Powers"
        let age = 12.0
        let height = 50.0
        let weight = 60.0
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
            try kid = KidService.sharedKidService.createKid(firstName, lastName: lastName, age: age, height: height, weight: weight, picture: nil, location: location!){}
        }
        catch let error {
            fatalError("Failed to add Kid: \(error)")
        }
        XCTAssertEqual(kid?.firstName, firstName, "The kids first name should be: \(firstName) but instead it is \(kid?.firstName)")
        XCTAssertEqual(kid?.lastName, lastName, "The kids last name should be: \(firstName) but instead it is \(kid?.lastName)")
        XCTAssertEqual(kid?.age, age, "The kids age should be: \(age) but instead it is \(kid?.age)")
        XCTAssertEqual(kid?.height, height, "The kids height should be: \(height) but instead it is \(kid?.height)")
        XCTAssertEqual(kid?.weight, weight, "The kids weight should be: \(weight) but instead it is \(kid?.weight)")
        XCTAssertEqual(kid?.location, location, "The kids location relationship doesn't match the given location")
        
//FETCH RESULTS CONTROLLER TEST
        
        let fetchedResultsController: NSFetchedResultsController? = KidService.sharedKidService.fetchedResultsControllerForKidsWithDelegate(nil, location: location)
        
        XCTAssertNotEqual(fetchedResultsController?.sections?.count, 0, "There aren't any sections in the fetchedResultsController")
        XCTAssertNotEqual(fetchedResultsController?.fetchedObjects?.count, 0, "There aren't any objects in the fetchedResultsController")
    }
    
}