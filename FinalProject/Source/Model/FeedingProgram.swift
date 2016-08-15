//
//  FeedingProgram.swift
//  FinalProject
//
//  Created by Mac Owner on 8/6/16.
//
//

import Foundation
import CoreData
import CoreDataService


class FeedingProgram: NSManagedObject, NamedEntity {
    class var entityName: String {
        get {
            return "FeedingProgram"
        }
    }
}
