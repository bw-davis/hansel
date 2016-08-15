//
//  FeedingRecord.swift
//  FinalProject
//
//  Created by Mac Owner on 8/6/16.
//
//

import Foundation
import CoreData
import CoreDataService


class FeedingRecord: NSManagedObject, NamedEntity {

    class var entityName: String {
        get {
            return "Location"
        }
    }
}
