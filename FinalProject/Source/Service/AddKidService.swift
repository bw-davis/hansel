//
//  AddKidService.swift
//  FinalProject
//
//  Created by Mac Owner on 8/7/16.
//
//

import Foundation
import CoreData
import CoreDataService

class KidService {
    static let sharedKidService = KidService()
    
    
    func fetchedResultsControllerForKidsWithDelegate(delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(namedEntity: Kid.self)
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
    
    func createKid(name: String, age: Double, height: Double, weight: Double) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let kid = NSEntityDescription.insertNewObjectForNamedEntity(Kid.self, inManagedObjectContext: context)
        kid.name = name
        kid.age = age
        kid.height = height
        kid.weight = weight
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext({})
    }
    private init(){
        
    }
    
}
