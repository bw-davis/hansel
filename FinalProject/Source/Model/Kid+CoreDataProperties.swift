//
//  Kid+CoreDataProperties.swift
//  FinalProject
//
//  Created by Mac Owner on 8/6/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Kid {

    @NSManaged var height: NSNumber?
    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var weight: NSNumber?
    @NSManaged var age: NSNumber?
    @NSManaged var feedingRecord: FeedingRecord?
    @NSManaged var firstPhoto: Photo?
    @NSManaged var latestPhoto: Photo?

}
