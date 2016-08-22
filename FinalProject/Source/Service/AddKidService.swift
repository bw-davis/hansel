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
    
    
    func fetchedResultsControllerForKidsWithDelegate(delegate: NSFetchedResultsControllerDelegate?, location: Location?) -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(namedEntity: Kid.self)
        if let someLocation = location {
           fetchRequest.predicate = NSPredicate(format: "location == %@", someLocation)
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
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
    
    func createKid(name: String, lastName: String, age: Double, height: Double, weight: Double, picture: UIImage?, location: Location, completionHandler: SaveCompletionHandler) throws -> Kid {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let kid = NSEntityDescription.insertNewObjectForNamedEntity(Kid.self, inManagedObjectContext: context)
        
        kid.firstName = name.capitalizedString
        kid.lastName = lastName.capitalizedString
        kid.age = age
        kid.height = height
        kid.weight = weight
        kid.location = location
        
        if let somePicture = picture, somePictureData = UIImageJPEGRepresentation(somePicture, 1.0){
            if let somePictureEntity = kid.firstPhoto as? Photo {
                somePictureEntity.data = somePictureData
            }
            else {
                let pictureEntity = NSEntityDescription.insertNewObjectForNamedEntity(Photo.self, inManagedObjectContext: context)
                pictureEntity.data = somePictureData
                pictureEntity.kidFirst = kid
            }
        }
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext(completionHandler)
        return kid
    }
    private init(){
        
    }
    
}
