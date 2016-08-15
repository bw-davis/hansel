//
//  FeedingRecord+CoreDataProperties.swift
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

extension FeedingRecord {

    @NSManaged var weight: NSNumber?
    @NSManaged var timeDate: NSDate?
    @NSManaged var day: NSSet?
    @NSManaged var kid: NSSet?
    @NSManaged var location: NSManagedObject?
    @NSManaged var photo: NSManagedObject?

}
