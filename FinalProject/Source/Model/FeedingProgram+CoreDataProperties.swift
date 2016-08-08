//
//  FeedingProgram+CoreDataProperties.swift
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

extension FeedingProgram {

    @NSManaged var name: String?
    @NSManaged var country: String?
    @NSManaged var locations: NSSet?

}
