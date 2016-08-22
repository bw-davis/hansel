//
//  LocationTests.swift
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

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateLocationForProperAttributeInsertion() {
        let feedingProgram: FeedingProgram?
        let location: Location?
        let name = "A Location"
        do {
            try feedingProgram = FeedingProgramService.sharedProgramService.createFeedingProgram("A Program", country: "A Country")
            XCTAssertNotEqual(feedingProgram, nil, "A FeedingProgram was not created")
        }
        catch let error {
            fatalError("Failed to add FeedingProgram: \(error)")
        }
        do {
            
            try location = LocationService.sharedLocationService.createLocation(name, longitude: 10.0, latitude: 10.0, feedingProgram: feedingProgram!)
        }
        catch let error {
            fatalError("Failed to add FeedingProgram: \(error)")
        }
        XCTAssertEqual(location?.name, name, "The locations name should be: \(name) but instead it is \(location?.name)")
        XCTAssertEqual(location?.longitude, 10.0, "The locations longitude should be: 10.0 but instead it is \(location?.longitude)")
        XCTAssertEqual(location?.latitude, 10.0, "The locations latitude should be: 10.0 but instead it is \(location?.latitude)")
        XCTAssertEqual(location?.feedingProgram, feedingProgram, "The locations feeding program relationship isn't correct.")
        
//FETCH RESULT CONTROLLER TEST
        
        let fetchedResultsController: NSFetchedResultsController? = LocationService.sharedLocationService.fetchedResultsControllerForLocationWithDelegate(nil, feedingProgram: feedingProgram)
        XCTAssertNotEqual(fetchedResultsController?.sections?.count, 0, "There aren't any sections in the fetchedResultsController")
        XCTAssertNotEqual(fetchedResultsController?.fetchedObjects?.count, 0, "There aren't any objects in the fetchedResultsController")
        
    }
    
}
