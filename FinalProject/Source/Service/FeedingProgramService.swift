//
//  FeedingProgramService.swift
//  FinalProject
//
//  Created by Mac Owner on 8/5/16.
//
//

import Foundation
import CoreData
import CoreDataService

class FeedingProgramService {
    
    static let sharedProgramService = FeedingProgramService()
    
    
    func fetchedResultsControllerForProgramsWithDelegate(delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(namedEntity: FeedingProgram.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
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
    
    func createFeedingProgram(name: String, country: String) throws -> FeedingProgram {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let program = NSEntityDescription.insertNewObjectForNamedEntity(FeedingProgram.self, inManagedObjectContext: context)
        program.name = name
        program.country = country
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext({})
        return program
    }
    private init(){
        
    }
}