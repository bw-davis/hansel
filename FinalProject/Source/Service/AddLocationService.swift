//
//  AddLocationService.swift
//  FinalProject
//
//  Created by Mac Owner on 8/5/16.
//
//

import Foundation
import CoreData
import CoreDataService

class LocationService {
    static let sharedLocationService = LocationService()
    
    func fetchedResultsControllerForLocationWithDelegate(delegate: NSFetchedResultsControllerDelegate?, feedingProgram: FeedingProgram) -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(namedEntity: Location.self)
        fetchRequest.predicate = NSPredicate(format: "feedingProgram == %@", feedingProgram)
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
    
    func createLocation(name: String, longitude: Double, latitude: Double/*, feedingProgram: FeedingProgram*/)throws  -> Location {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let location = NSEntityDescription.insertNewObjectForNamedEntity(Location.self, inManagedObjectContext: context)
        location.name = name
        location.longitude = longitude
        location.latitude = latitude
        //location.feedingProgram = feedingProgram
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext({})
        return location
    }
    private init(){
        
    }
    
}