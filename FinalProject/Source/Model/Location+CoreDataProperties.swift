//
//  Location+CoreDataProperties.swift
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

extension Location {

    @NSManaged var name: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var feedingProgram: NSManagedObject?
    @NSManaged var feedingRecord: NSSet?
    @NSManaged var kid: NSSet?

}
