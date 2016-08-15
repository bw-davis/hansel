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
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var notes: String?
    @NSManaged var weight: NSNumber?
    @NSManaged var age: NSNumber?
    @NSManaged var feedingRecord: NSSet?
    @NSManaged var firstPhoto: NSManagedObject?
    @NSManaged var latestPhoto: NSManagedObject?
    @NSManaged var location: NSManagedObject?

}
