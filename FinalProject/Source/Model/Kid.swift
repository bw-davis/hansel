//
//  Kid.swift
//  FinalProject
//
//  Created by Mac Owner on 8/6/16.
//
//

import Foundation
import CoreData
import CoreDataService


class Kid: NSManagedObject, NamedEntity {
    // MARK: Properties (Class, NamedEntity)
    class var entityName: String {
        get {
            return "Kid"
        }
    }
}
