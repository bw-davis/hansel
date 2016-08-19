//
//  FeedingRecordService.swift
//  FinalProject
//
//  Created by Mac Owner on 8/14/16.
//
//

import Foundation
import CoreData
import CoreDataService

class FeedingRecordService {
    static let sharedFeedingRecordService = FeedingRecordService()
    
    
    func fetchedResultsControllerForFeedingRecordWithDelegate(delegate: NSFetchedResultsControllerDelegate?, kid: Kid?) -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(namedEntity: FeedingRecord.self)
        if let someKid = kid {
            fetchRequest.predicate = NSPredicate(format: "kid == %@", someKid)
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeDate", ascending: true)]
        var resultsController: NSFetchedResultsController? = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.sharedCoreDataService.mainQueueContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try resultsController?.performFetch()
        }
        catch _ {
            resultsController = nil
        }
        
        resultsController?.delegate = delegate
        return resultsController
        
    }
    
    func createFeedingRecord(weight: Double, date: NSDate, notes: String?, completionHandler: SaveCompletionHandler) throws -> FeedingRecord {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let feedingRecord = NSEntityDescription.insertNewObjectForNamedEntity(FeedingRecord.self, inManagedObjectContext: context)
        let day = NSEntityDescription.insertNewObjectForNamedEntity(Day.self, inManagedObjectContext: context)
        
        day.dateTime = date
        feedingRecord.weight = weight
       
        feedingRecord.day = day
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext(completionHandler)
        return feedingRecord
    }
    private init(){
        
    }
    
}
